const Scte35ArchiveAllowedFlag = @import("scte_35_archive_allowed_flag.zig").Scte35ArchiveAllowedFlag;
const Scte35DeviceRestrictions = @import("scte_35_device_restrictions.zig").Scte35DeviceRestrictions;
const Scte35NoRegionalBlackoutFlag = @import("scte_35_no_regional_blackout_flag.zig").Scte35NoRegionalBlackoutFlag;
const Scte35WebDeliveryAllowedFlag = @import("scte_35_web_delivery_allowed_flag.zig").Scte35WebDeliveryAllowedFlag;

/// Corresponds to SCTE-35 delivery_not_restricted_flag parameter. To declare
/// delivery restrictions, include this element and its four "restriction"
/// flags. To declare that there are no restrictions, omit this element.
pub const Scte35DeliveryRestrictions = struct {
    /// Corresponds to SCTE-35 archive_allowed_flag.
    archive_allowed_flag: Scte35ArchiveAllowedFlag,

    /// Corresponds to SCTE-35 device_restrictions parameter.
    device_restrictions: Scte35DeviceRestrictions,

    /// Corresponds to SCTE-35 no_regional_blackout_flag parameter.
    no_regional_blackout_flag: Scte35NoRegionalBlackoutFlag,

    /// Corresponds to SCTE-35 web_delivery_allowed_flag parameter.
    web_delivery_allowed_flag: Scte35WebDeliveryAllowedFlag,

    pub const json_field_names = .{
        .archive_allowed_flag = "ArchiveAllowedFlag",
        .device_restrictions = "DeviceRestrictions",
        .no_regional_blackout_flag = "NoRegionalBlackoutFlag",
        .web_delivery_allowed_flag = "WebDeliveryAllowedFlag",
    };
};
