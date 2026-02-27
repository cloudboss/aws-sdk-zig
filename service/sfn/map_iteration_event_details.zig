/// Contains details about an iteration of a Map state.
pub const MapIterationEventDetails = struct {
    /// The index of the array belonging to the Map state iteration.
    index: i32 = 0,

    /// The name of the iteration’s parent Map state.
    name: ?[]const u8,

    pub const json_field_names = .{
        .index = "index",
        .name = "name",
    };
};
