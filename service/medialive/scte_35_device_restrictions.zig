/// Corresponds to the device_restrictions parameter in a
/// segmentation_descriptor. If you include one of the "restriction" flags then
/// you must include all four of them.
pub const Scte35DeviceRestrictions = enum {
    none,
    restrict_group0,
    restrict_group1,
    restrict_group2,

    pub const json_field_names = .{
        .none = "NONE",
        .restrict_group0 = "RESTRICT_GROUP0",
        .restrict_group1 = "RESTRICT_GROUP1",
        .restrict_group2 = "RESTRICT_GROUP2",
    };
};
