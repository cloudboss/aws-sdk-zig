/// Contains details about a Map Run that was redriven.
pub const MapRunRedrivenEventDetails = struct {
    /// The Amazon Resource Name (ARN) of a Map Run that was redriven.
    map_run_arn: ?[]const u8 = null,

    /// The number of times the Map Run has been redriven at this point in the
    /// execution's history including this event. The redrive count for a redriven
    /// Map Run is always greater than 0.
    redrive_count: ?i32 = null,

    pub const json_field_names = .{
        .map_run_arn = "mapRunArn",
        .redrive_count = "redriveCount",
    };
};
