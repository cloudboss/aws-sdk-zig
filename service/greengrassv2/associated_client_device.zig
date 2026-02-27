/// Contains information about a client device that is associated to a core
/// device for cloud
/// discovery.
pub const AssociatedClientDevice = struct {
    /// The time that the client device was associated, expressed in ISO 8601
    /// format.
    association_timestamp: ?i64,

    /// The name of the IoT thing that represents the associated client device.
    thing_name: ?[]const u8,

    pub const json_field_names = .{
        .association_timestamp = "associationTimestamp",
        .thing_name = "thingName",
    };
};
