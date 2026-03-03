const BrazilAdditionalInfo = @import("brazil_additional_info.zig").BrazilAdditionalInfo;
const CanadaAdditionalInfo = @import("canada_additional_info.zig").CanadaAdditionalInfo;
const EgyptAdditionalInfo = @import("egypt_additional_info.zig").EgyptAdditionalInfo;
const EstoniaAdditionalInfo = @import("estonia_additional_info.zig").EstoniaAdditionalInfo;
const GeorgiaAdditionalInfo = @import("georgia_additional_info.zig").GeorgiaAdditionalInfo;
const GreeceAdditionalInfo = @import("greece_additional_info.zig").GreeceAdditionalInfo;
const IndiaAdditionalInfo = @import("india_additional_info.zig").IndiaAdditionalInfo;
const IndonesiaAdditionalInfo = @import("indonesia_additional_info.zig").IndonesiaAdditionalInfo;
const IsraelAdditionalInfo = @import("israel_additional_info.zig").IsraelAdditionalInfo;
const ItalyAdditionalInfo = @import("italy_additional_info.zig").ItalyAdditionalInfo;
const KenyaAdditionalInfo = @import("kenya_additional_info.zig").KenyaAdditionalInfo;
const MalaysiaAdditionalInfo = @import("malaysia_additional_info.zig").MalaysiaAdditionalInfo;
const PolandAdditionalInfo = @import("poland_additional_info.zig").PolandAdditionalInfo;
const RomaniaAdditionalInfo = @import("romania_additional_info.zig").RomaniaAdditionalInfo;
const SaudiArabiaAdditionalInfo = @import("saudi_arabia_additional_info.zig").SaudiArabiaAdditionalInfo;
const SouthKoreaAdditionalInfo = @import("south_korea_additional_info.zig").SouthKoreaAdditionalInfo;
const SpainAdditionalInfo = @import("spain_additional_info.zig").SpainAdditionalInfo;
const TurkeyAdditionalInfo = @import("turkey_additional_info.zig").TurkeyAdditionalInfo;
const UkraineAdditionalInfo = @import("ukraine_additional_info.zig").UkraineAdditionalInfo;
const UzbekistanAdditionalInfo = @import("uzbekistan_additional_info.zig").UzbekistanAdditionalInfo;
const VietnamAdditionalInfo = @import("vietnam_additional_info.zig").VietnamAdditionalInfo;

/// Additional tax information associated with your TRN. The Tax Settings API
/// returns
/// country-specific information in the response when any additional information
/// is present with
/// your TRN for the following countries.
pub const AdditionalInfoResponse = struct {
    /// Additional tax information associated with your TRN in Brazil. The Tax
    /// Settings API
    /// returns this information in your response when any additional information is
    /// present with your
    /// TRN in Brazil.
    brazil_additional_info: ?BrazilAdditionalInfo = null,

    /// Additional tax information associated with your TRN in Canada.
    canada_additional_info: ?CanadaAdditionalInfo = null,

    /// Additional tax information to specify for a TRN in Egypt.
    egypt_additional_info: ?EgyptAdditionalInfo = null,

    /// Additional tax information associated with your TRN in Estonia.
    estonia_additional_info: ?EstoniaAdditionalInfo = null,

    /// Additional tax information associated with your TRN in Georgia.
    georgia_additional_info: ?GeorgiaAdditionalInfo = null,

    /// Additional tax information to specify for a TRN in Greece.
    greece_additional_info: ?GreeceAdditionalInfo = null,

    /// Additional tax information in India.
    india_additional_info: ?IndiaAdditionalInfo = null,

    /// Additional tax information associated with your TRN in Indonesia.
    indonesia_additional_info: ?IndonesiaAdditionalInfo = null,

    /// Additional tax information associated with your TRN in Israel.
    israel_additional_info: ?IsraelAdditionalInfo = null,

    /// Additional tax information associated with your TRN in Italy.
    italy_additional_info: ?ItalyAdditionalInfo = null,

    /// Additional tax information associated with your TRN in Kenya.
    kenya_additional_info: ?KenyaAdditionalInfo = null,

    /// Additional tax information associated with your TRN in Malaysia.
    malaysia_additional_info: ?MalaysiaAdditionalInfo = null,

    /// Additional tax information associated with your TRN in Poland.
    poland_additional_info: ?PolandAdditionalInfo = null,

    /// Additional tax information to specify for a TRN in Romania.
    romania_additional_info: ?RomaniaAdditionalInfo = null,

    /// Additional tax information associated with your TRN in Saudi Arabia.
    saudi_arabia_additional_info: ?SaudiArabiaAdditionalInfo = null,

    /// Additional tax information associated with your TRN in South Korea.
    south_korea_additional_info: ?SouthKoreaAdditionalInfo = null,

    /// Additional tax information associated with your TRN in Spain.
    spain_additional_info: ?SpainAdditionalInfo = null,

    /// Additional tax information associated with your TRN in Turkey.
    turkey_additional_info: ?TurkeyAdditionalInfo = null,

    /// Additional tax information associated with your TRN in Ukraine.
    ukraine_additional_info: ?UkraineAdditionalInfo = null,

    /// Additional tax information associated with your TRN in Uzbekistan.
    uzbekistan_additional_info: ?UzbekistanAdditionalInfo = null,

    /// Additional tax information to specify for a TRN in Vietnam.
    vietnam_additional_info: ?VietnamAdditionalInfo = null,

    pub const json_field_names = .{
        .brazil_additional_info = "brazilAdditionalInfo",
        .canada_additional_info = "canadaAdditionalInfo",
        .egypt_additional_info = "egyptAdditionalInfo",
        .estonia_additional_info = "estoniaAdditionalInfo",
        .georgia_additional_info = "georgiaAdditionalInfo",
        .greece_additional_info = "greeceAdditionalInfo",
        .india_additional_info = "indiaAdditionalInfo",
        .indonesia_additional_info = "indonesiaAdditionalInfo",
        .israel_additional_info = "israelAdditionalInfo",
        .italy_additional_info = "italyAdditionalInfo",
        .kenya_additional_info = "kenyaAdditionalInfo",
        .malaysia_additional_info = "malaysiaAdditionalInfo",
        .poland_additional_info = "polandAdditionalInfo",
        .romania_additional_info = "romaniaAdditionalInfo",
        .saudi_arabia_additional_info = "saudiArabiaAdditionalInfo",
        .south_korea_additional_info = "southKoreaAdditionalInfo",
        .spain_additional_info = "spainAdditionalInfo",
        .turkey_additional_info = "turkeyAdditionalInfo",
        .ukraine_additional_info = "ukraineAdditionalInfo",
        .uzbekistan_additional_info = "uzbekistanAdditionalInfo",
        .vietnam_additional_info = "vietnamAdditionalInfo",
    };
};
