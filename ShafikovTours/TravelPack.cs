//------------------------------------------------------------------------------
// <auto-generated>
//     Этот код создан по шаблону.
//
//     Изменения, вносимые в этот файл вручную, могут привести к непредвиденной работе приложения.
//     Изменения, вносимые в этот файл вручную, будут перезаписаны при повторном создании кода.
// </auto-generated>
//------------------------------------------------------------------------------

namespace ShafikovTours
{
    using System;
    using System.Collections.Generic;
    
    public partial class TravelPack
    {
        public int TravelPackID { get; set; }
        public int ClientID { get; set; }
        public int PensionID { get; set; }
        public System.DateTime TravelPackArrivData { get; set; }
        public System.DateTime TravelPackDepartDate { get; set; }
        public bool TravelPackChild { get; set; }
        public bool TravelPackMedInsur { get; set; }
        public int TravelPackPeopleCount { get; set; }
        public decimal TravelPackPrice { get; set; }
    
        public virtual Client Client { get; set; }
        public virtual Pension Pension { get; set; }
    }
}
