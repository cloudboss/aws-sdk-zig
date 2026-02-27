const aws = @import("aws");

const AssignedVariablesDetails = @import("assigned_variables_details.zig").AssignedVariablesDetails;
const HistoryEventExecutionDataDetails = @import("history_event_execution_data_details.zig").HistoryEventExecutionDataDetails;

/// Contains details about an exit from a state during an execution.
pub const StateExitedEventDetails = struct {
    /// Map of variable name and value as a serialized JSON representation.
    assigned_variables: ?[]const aws.map.StringMapEntry,

    /// Provides details about input or output in an execution history event.
    assigned_variables_details: ?AssignedVariablesDetails,

    /// The name of the state.
    ///
    /// A name must *not* contain:
    ///
    /// * white space
    ///
    /// * brackets ` { } [ ]`
    ///
    /// * wildcard characters `? *`
    ///
    /// * special characters `" # % \ ^ | ~ ` $ & , ; : /`
    ///
    /// * control characters (`U+0000-001F`, `U+007F-009F`, `U+FFFE-FFFF`)
    ///
    /// * surrogates (`U+D800-DFFF`)
    ///
    /// * invalid characters (` U+10FFFF`)
    ///
    /// To enable logging with CloudWatch Logs, the name should only contain 0-9,
    /// A-Z, a-z, - and _.
    name: []const u8,

    /// The JSON output data of the state. Length constraints apply to the payload
    /// size, and are expressed as bytes in UTF-8 encoding.
    output: ?[]const u8,

    /// Contains details about the output of an execution history event.
    output_details: ?HistoryEventExecutionDataDetails,

    pub const json_field_names = .{
        .assigned_variables = "assignedVariables",
        .assigned_variables_details = "assignedVariablesDetails",
        .name = "name",
        .output = "output",
        .output_details = "outputDetails",
    };
};
