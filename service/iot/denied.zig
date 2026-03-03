const ExplicitDeny = @import("explicit_deny.zig").ExplicitDeny;
const ImplicitDeny = @import("implicit_deny.zig").ImplicitDeny;

/// Contains information that denied the authorization.
pub const Denied = struct {
    /// Information that explicitly denies the authorization.
    explicit_deny: ?ExplicitDeny = null,

    /// Information that implicitly denies the authorization. When a policy doesn't
    /// explicitly deny or allow an action on a resource it is considered an
    /// implicit
    /// deny.
    implicit_deny: ?ImplicitDeny = null,

    pub const json_field_names = .{
        .explicit_deny = "explicitDeny",
        .implicit_deny = "implicitDeny",
    };
};
