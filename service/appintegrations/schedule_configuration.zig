/// The name of the data and how often it should be pulled from the source.
pub const ScheduleConfiguration = struct {
    /// The start date for objects to import in the first flow run as an Unix/epoch
    /// timestamp in
    /// milliseconds or in ISO-8601 format.
    first_execution_from: ?[]const u8 = null,

    /// The name of the object to pull from the data source.
    object: ?[]const u8 = null,

    /// How often the data should be pulled from data source.
    schedule_expression: []const u8,

    pub const json_field_names = .{
        .first_execution_from = "FirstExecutionFrom",
        .object = "Object",
        .schedule_expression = "ScheduleExpression",
    };
};
