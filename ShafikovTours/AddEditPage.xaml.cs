using Microsoft.Win32;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace ShafikovTours
{
    /// <summary>
    /// Логика взаимодействия для AddEditPage.xaml
    /// </summary>
    public partial class AddEditPage : Page
    {
        Tour currentTour = new Tour();
        bool checkTour = false;
        public AddEditPage(Tour selectedTour)
        {
            InitializeComponent();

            if(selectedTour != null)
            {
                currentTour = selectedTour;
                checkTour = true;

                DelBtn.Visibility = Visibility.Visible;

                TransportTBox.SelectedIndex = currentTour.TransportID;
                HousingTBox.SelectedIndex = currentTour.HousingTypeID;

                /*if (currentTour.TourTransport == "Автобус")
                {
                    TransportTBox.SelectedIndex = 1;
                }
                else if (currentTour.TourTransport == "Поезд")
                {
                    TransportTBox.SelectedIndex = 2;
                }
                else if (currentTour.TourTransport == "Самолёт")
                {
                    TransportTBox.SelectedIndex = 3;
                }

                if (currentTour.TourHousingCategory == "Гостиница")
                {
                    HousingTBox.SelectedIndex = 1;
                }
                else if (currentTour.TourHousingCategory == "Отель")
                {
                    HousingTBox.SelectedIndex = 2;
                }*/

            }

            DataContext = currentTour;
        }

        private void TransportTBox_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {

        }

        private void HousingTBox_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {

        }

        private void ChangePictureBtn_Click(object sender, RoutedEventArgs e)
        {
            OpenFileDialog myOpenFileDialog = new OpenFileDialog();
            if (myOpenFileDialog.ShowDialog() == true)
            {
                currentTour.TourPhoto = myOpenFileDialog.FileName;
                LogoImage.Source = new BitmapImage(new Uri(myOpenFileDialog.FileName));
            }
        }

        private void SaveBtn_Click(object sender, RoutedEventArgs e)
        {
            StringBuilder errors = new StringBuilder();
            if (string.IsNullOrWhiteSpace(currentTour.TourName))
                errors.AppendLine("Укажите название тура");
            if (string.IsNullOrWhiteSpace(currentTour.TourEatType))
                errors.AppendLine("Укажите тип еды");
            if (string.IsNullOrWhiteSpace(PriceTBox.Text))
                errors.AppendLine("Укажите стоимость тура в день");
            else if(currentTour.TourDayPrice <= 0)
                errors.AppendLine("Некорректная стоимость");
            if (string.IsNullOrWhiteSpace(currentTour.TourCity))
                errors.AppendLine("Укажите город");
            if (TransportTBox.SelectedItem == null || TransportTBox.SelectedIndex == 0)
                errors.AppendLine("Укажите транспорт для отправления в тур");
            if (HousingTBox.SelectedItem == null || HousingTBox.SelectedIndex == 0)
                errors.AppendLine("Укажите тип проживания");
            if (errors.Length > 0)
            {
                MessageBox.Show(errors.ToString());
                return;
            }

            var allTour = TravelAgencyEntities.GetContext().Tour.ToList();
            allTour = allTour.Where(t => t.TourName == currentTour.TourName).ToList();

            if (allTour.Count == 0 || (checkTour == true && allTour.Count <= 1))
            {
                if (TransportTBox.SelectedIndex == 1)
                {
                    currentTour.TransportID = 1;
                }
                else if (TransportTBox.SelectedIndex == 2)
                {
                    currentTour.TransportID = 2;
                }
                else if (TransportTBox.SelectedIndex == 3)
                {
                    currentTour.TransportID = 3;
                }

                if (HousingTBox.SelectedIndex == 1)
                {
                    currentTour.HousingTypeID = 1;
                }
                else if (HousingTBox.SelectedIndex == 2)
                {
                    currentTour.HousingTypeID = 2;
                }

                if (currentTour.TourID == 0)
                    TravelAgencyEntities.GetContext().Tour.Add(currentTour);

                try
                {
                    TravelAgencyEntities.GetContext().SaveChanges();
                    MessageBox.Show("Информация сохранена");
                    Manager.MainFrame.GoBack();
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message.ToString());
                }
            }
            else
            {
                MessageBox.Show("Такой тур уже существует");
            }
        }

        private void DelBtn_Click(object sender, RoutedEventArgs e)
        {
            var _currentTour = (sender as Button).DataContext as Tour;

            var _currentTourSell = TravelAgencyEntities.GetContext().TourSell.ToList();
            _currentTourSell = _currentTourSell.Where(t => t.TourID == _currentTour.TourID).ToList();

            if (_currentTourSell.Count != 0)
            {
                MessageBox.Show("Невозможно выполнить удаление, так как существуют записи");
            }
            else
            {
                if (MessageBox.Show("Вы точно хотите выполнить удаление?", "Внимание!",
                    MessageBoxButton.YesNo, MessageBoxImage.Question) == MessageBoxResult.Yes)
                {
                    try
                    {
                        TravelAgencyEntities.GetContext().Tour.Remove(_currentTour);
                        TravelAgencyEntities.GetContext().SaveChanges();
                        //TourPage.UpdatePage();
                        Manager.MainFrame.GoBack();
                    }
                    catch (Exception ex)
                    {
                        MessageBox.Show(ex.Message.ToString());
                    }
                }
            }
        }
    }
}
