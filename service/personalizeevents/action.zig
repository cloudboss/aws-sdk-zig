/// Represents action metadata added to an Action dataset using the
/// `PutActions` API. For more information see
/// [Importing actions
/// individually](https://docs.aws.amazon.com/personalize/latest/dg/importing-actions.html).
pub const Action = struct {
    /// The ID associated with the action.
    action_id: []const u8,

    /// A string map of action-specific metadata. Each element in the map consists
    /// of a key-value pair.
    /// For example, `{"value": "100"}`.
    ///
    /// The keys use camel case names that match the fields in the schema for the
    /// Actions
    /// dataset. In the previous example, the `value` matches the
    /// 'VALUE' field defined in the Actions schema. For categorical string data, to
    /// include multiple categories for a single action,
    /// separate each category with a pipe separator (`|`). For example,
    /// `\"Deluxe|Premium\"`.
    properties: ?[]const u8,

    pub const json_field_names = .{
        .action_id = "actionId",
        .properties = "properties",
    };
};
