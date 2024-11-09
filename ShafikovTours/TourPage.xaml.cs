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
    /// Логика взаимодействия для TourPage.xaml
    /// </summary>
    public partial class TourPage : Page
    {
       
        public TourPage()
        {
            InitializeComponent();

            var currentTour = TravelAgencyEntities.GetContext().Tour.ToList();
            TourList.ItemsSource = currentTour;

            PriceCombo.SelectedIndex = 0;
            TransportCombo.SelectedIndex = 0;
            HouseCombo.SelectedIndex = 0;

            allProductCountTB.Text = currentTour.Count.ToString();

            UpdateTour();
        }

        public void UpdateTour()
        {
            var currentTour = TravelAgencyEntities.GetContext().Tour.ToList();

            currentTour = currentTour.Where(t => (t.TourName.ToLower().Contains(SearchTBox.Text.ToLower())
            || t.TourCity.ToLower().Contains(SearchTBox.Text.ToLower()))).ToList();

            if(PriceCombo.SelectedIndex == 0)
            {
                currentTour = currentTour.Where(t => t.TourDayPrice == t.TourDayPrice).ToList();
            }
            else if(PriceCombo.SelectedIndex == 1)
            {
                currentTour = currentTour.OrderBy(t => t.TourDayPrice).ToList();
            }
            else if(PriceCombo.SelectedIndex == 2)
            {
                currentTour = currentTour.OrderByDescending(t => t.TourDayPrice).ToList();
            }

            if(HouseCombo.SelectedIndex == 0)
            {
                currentTour = currentTour.Where(t => t.TourHousingType == t.TourHousingType).ToList();
            }
            else if(HouseCombo.SelectedIndex == 1)
            {
                currentTour = currentTour.Where(t => t.TourHousingType.ToLower() == "Отель".ToLower()).ToList();
            }
            else if (HouseCombo.SelectedIndex == 2)
            {
                currentTour = currentTour.Where(t => t.TourHousingType.ToLower() == "Гостиница".ToLower()).ToList();
            }

            if (TransportCombo.SelectedIndex == 0)
            {
                currentTour = currentTour.Where(t => t.TourTransportType == t.TourTransportType).ToList();
            }
            else if (TransportCombo.SelectedIndex == 1)
            {
                currentTour = currentTour.Where(t => t.TourTransportType.ToLower() == "Автобус".ToLower()).ToList();
            }
            else if (TransportCombo.SelectedIndex == 2)
            {
                currentTour = currentTour.Where(t => t.TourTransportType.ToLower() == "Поезд".ToLower()).ToList();
            }
            else if (TransportCombo.SelectedIndex == 3)
            {
                currentTour = currentTour.Where(t => t.TourTransportType.ToLower() == "Самолёт".ToLower() || t.TourTransportType.ToLower() == "Самолет".ToLower()).ToList();
            }

            atProductCountTB.Text = currentTour.Count.ToString();
            allProductCountTB.Text = TravelAgencyEntities.GetContext().Tour.ToList().Count.ToString();

            TourList.ItemsSource = currentTour;
            TourList.Items.Refresh();
        }

        private void SearchTBox_TextChanged(object sender, TextChangedEventArgs e)
        {
            UpdateTour();
        }

        private void PriceCombo_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            UpdateTour();
        }

        private void HouseCombo_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            UpdateTour();
        }

        private void TransportCombo_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            UpdateTour();
        }

        private void TourList_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {

        }

        private void EditBtn_Click(object sender, RoutedEventArgs e)
        {
            Manager.MainFrame.Navigate(new AddEditPage((sender as Button).DataContext as Tour));
            UpdateTour();
        }

        private void AddBtn_Click(object sender, RoutedEventArgs e)
        {
            Manager.MainFrame.Navigate(new AddEditPage(null));
            //PriceCombo.SelectedIndex = 1;
            //PriceCombo.SelectedIndex = 0;
            UpdateTour();
        }

        private void Page_IsVisibleChanged(object sender, DependencyPropertyChangedEventArgs e)
        {
            if (Visibility == Visibility.Visible)
            {
                TravelAgencyEntities.GetContext().ChangeTracker.Entries().ToList().ForEach(t => t.Reload());
                TourList.ItemsSource = TravelAgencyEntities.GetContext().Tour.ToList();
            }
            UpdateTour();
        }
    }
}
