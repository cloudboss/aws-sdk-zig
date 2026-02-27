/// The details of the worker amount capability.
pub const WorkerAmountCapability = struct {
    /// The name of the worker amount capability.
    name: []const u8,

    /// The value of the worker amount capability.
    value: f32,

    pub const json_field_names = .{
        .name = "name",
        .value = "value",
    };
};
