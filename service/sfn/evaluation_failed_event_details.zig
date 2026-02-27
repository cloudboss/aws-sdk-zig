/// Contains details about an evaluation failure that occurred while processing
/// a state, for example, when a JSONata expression throws an error. This event
/// will only be present in state machines that have ** QueryLanguage** set to
/// JSONata, or individual states set to JSONata.
pub const EvaluationFailedEventDetails = struct {
    /// A more detailed explanation of the cause of the failure.
    cause: ?[]const u8,

    /// The error code of the failure.
    @"error": ?[]const u8,

    /// The location of the field in the state in which the evaluation error
    /// occurred.
    location: ?[]const u8,

    /// The name of the state in which the evaluation error occurred.
    state: []const u8,

    pub const json_field_names = .{
        .cause = "cause",
        .@"error" = "error",
        .location = "location",
        .state = "state",
    };
};
