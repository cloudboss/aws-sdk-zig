/// An object that represents an Batch array job.
pub const ArrayProperties = struct {
    /// The size of the array job.
    size: ?i32,

    pub const json_field_names = .{
        .size = "size",
    };
};
