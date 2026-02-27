/// Contains information about the Autonomous System (AS) associated with the
/// network
/// endpoints involved in an attack sequence.
pub const AutonomousSystem = struct {
    /// Name associated with the Autonomous System (AS).
    name: []const u8,

    /// The unique number that identifies the Autonomous System (AS).
    number: i32,

    pub const json_field_names = .{
        .name = "Name",
        .number = "Number",
    };
};
