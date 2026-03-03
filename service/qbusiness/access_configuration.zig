const AccessControl = @import("access_control.zig").AccessControl;
const MemberRelation = @import("member_relation.zig").MemberRelation;

/// Used to configure access permissions for a document.
pub const AccessConfiguration = struct {
    /// A list of `AccessControlList` objects.
    access_controls: []const AccessControl,

    /// Describes the member relation within the `AccessControlList` object.
    member_relation: ?MemberRelation = null,

    pub const json_field_names = .{
        .access_controls = "accessControls",
        .member_relation = "memberRelation",
    };
};
