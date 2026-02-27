/// Details about a Map state that was started.
pub const MapStateStartedEventDetails = struct {
    /// The size of the array for Map state iterations.
    length: i32 = 0,

    pub const json_field_names = .{
        .length = "length",
    };
};
