const AuthType = @import("auth_type.zig").AuthType;
const UserAssignment = @import("user_assignment.zig").UserAssignment;

/// The single sign-on details in Amazon DataZone.
pub const SingleSignOn = struct {
    /// The ARN of the IDC instance.
    idc_instance_arn: ?[]const u8,

    /// The type of single sign-on in Amazon DataZone.
    type: ?AuthType,

    /// The single sign-on user assignment in Amazon DataZone.
    user_assignment: ?UserAssignment,

    pub const json_field_names = .{
        .idc_instance_arn = "idcInstanceArn",
        .type = "type",
        .user_assignment = "userAssignment",
    };
};
