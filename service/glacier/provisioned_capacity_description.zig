/// The definition for a provisioned capacity unit.
pub const ProvisionedCapacityDescription = struct {
    /// The ID that identifies the provisioned capacity unit.
    capacity_id: ?[]const u8,

    /// The date that the provisioned capacity unit expires, in Universal
    /// Coordinated Time (UTC).
    expiration_date: ?[]const u8,

    /// The date that the provisioned capacity unit was purchased, in Universal
    /// Coordinated Time (UTC).
    start_date: ?[]const u8,

    pub const json_field_names = .{
        .capacity_id = "CapacityId",
        .expiration_date = "ExpirationDate",
        .start_date = "StartDate",
    };
};
