/// Contains information about an action for a request for which an
/// authorization decision is made.
///
/// This data type is used as a request parameter to the
/// [IsAuthorized](https://docs.aws.amazon.com/verifiedpermissions/latest/apireference/API_IsAuthorized.html), [BatchIsAuthorized](https://docs.aws.amazon.com/verifiedpermissions/latest/apireference/API_BatchIsAuthorized.html), and [IsAuthorizedWithToken](https://docs.aws.amazon.com/verifiedpermissions/latest/apireference/API_IsAuthorizedWithToken.html) operations.
///
/// Example: `{ "actionId": "<action name>", "actionType": "Action" }`
pub const ActionIdentifier = struct {
    /// The ID of an action.
    action_id: []const u8,

    /// The type of an action.
    action_type: []const u8,

    pub const json_field_names = .{
        .action_id = "actionId",
        .action_type = "actionType",
    };
};
