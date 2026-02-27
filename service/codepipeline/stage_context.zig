/// Represents information about a stage to a job worker.
pub const StageContext = struct {
    /// The name of the stage.
    name: ?[]const u8,

    pub const json_field_names = .{
        .name = "name",
    };
};
