/// Contains details about a Map Run that was started during a state machine
/// execution.
pub const MapRunStartedEventDetails = struct {
    /// The Amazon Resource Name (ARN) of a Map Run that was started.
    map_run_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .map_run_arn = "mapRunArn",
    };
};
