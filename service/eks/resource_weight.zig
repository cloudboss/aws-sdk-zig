/// A resource weight entry for the scheduler scoring strategy.
pub const ResourceWeight = struct {
    /// The name of the resource (for example, `cpu` or `memory`).
    name: ?[]const u8 = null,

    /// The weight assigned to the resource for scoring. Must be between 1 and 100.
    weight: ?i32 = null,

    pub const json_field_names = .{
        .name = "name",
        .weight = "weight",
    };
};
