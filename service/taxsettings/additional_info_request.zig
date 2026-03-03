const CanadaAdditionalInfo = @import("canada_additional_info.zig").CanadaAdditionalInfo;
const EgyptAdditionalInfo = @import("egypt_additional_info.zig").EgyptAdditionalInfo;
const EstoniaAdditionalInfo = @import("estonia_additional_info.zig").EstoniaAdditionalInfo;
const GeorgiaAdditionalInfo = @import("georgia_additional_info.zig").GeorgiaAdditionalInfo;
const GreeceAdditionalInfo = @import("greece_additional_info.zig").GreeceAdditionalInfo;
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

/// Additional tax information associated with your tax registration number
/// (TRN). Depending
/// on the TRN for a specific country, you might need to specify this
/// information when you set
/// your TRN.
///
/// You can only specify one of the following parameters and the value can't be
/// empty.
///
/// The parameter that you specify must match the country for the TRN, if
/// available. For
/// example, if you set a TRN in Canada for specific provinces, you must also
/// specify the
/// `canadaAdditionalInfo` parameter.
pub const AdditionalInfoRequest = struct {
    /// Additional tax information associated with your TRN in Canada.
    canada_additional_info: ?CanadaAdditionalInfo = null,

    /// Additional tax information to specify for a TRN in Egypt.
    egypt_additional_info: ?EgyptAdditionalInfo = null,

    /// Additional tax information to specify for a TRN in Estonia.
    estonia_additional_info: ?EstoniaAdditionalInfo = null,

    /// Additional tax information to specify for a TRN in Georgia.
    georgia_additional_info: ?GeorgiaAdditionalInfo = null,

    /// Additional tax information to specify for a TRN in Greece.
    greece_additional_info: ?GreeceAdditionalInfo = null,

    indonesia_additional_info: ?IndonesiaAdditionalInfo = null,

    /// Additional tax information to specify for a TRN in Israel.
    israel_additional_info: ?IsraelAdditionalInfo = null,

    /// Additional tax information to specify for a TRN in Italy.
    italy_additional_info: ?ItalyAdditionalInfo = null,

    /// Additional tax information to specify for a TRN in Kenya.
    kenya_additional_info: ?KenyaAdditionalInfo = null,

    /// Additional tax information to specify for a TRN in Malaysia.
    malaysia_additional_info: ?MalaysiaAdditionalInfo = null,

    /// Additional tax information associated with your TRN in Poland.
    poland_additional_info: ?PolandAdditionalInfo = null,

    /// Additional tax information to specify for a TRN in Romania.
    romania_additional_info: ?RomaniaAdditionalInfo = null,

    /// Additional tax information associated with your TRN in Saudi Arabia.
    saudi_arabia_additional_info: ?SaudiArabiaAdditionalInfo = null,

    /// Additional tax information to specify for a TRN in South Korea.
    south_korea_additional_info: ?SouthKoreaAdditionalInfo = null,

    /// Additional tax information to specify for a TRN in Spain.
    spain_additional_info: ?SpainAdditionalInfo = null,

    /// Additional tax information to specify for a TRN in Turkey.
    turkey_additional_info: ?TurkeyAdditionalInfo = null,

    /// Additional tax information associated with your TRN in Ukraine.
    ukraine_additional_info: ?UkraineAdditionalInfo = null,

    /// Additional tax information to specify for a TRN in Uzbekistan.
    uzbekistan_additional_info: ?UzbekistanAdditionalInfo = null,

    /// Additional tax information to specify for a TRN in Vietnam.
    vietnam_additional_info: ?VietnamAdditionalInfo = null,

    pub const json_field_names = .{
        .canada_additional_info = "canadaAdditionalInfo",
        .egypt_additional_info = "egyptAdditionalInfo",
        .estonia_additional_info = "estoniaAdditionalInfo",
        .georgia_additional_info = "georgiaAdditionalInfo",
        .greece_additional_info = "greeceAdditionalInfo",
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
