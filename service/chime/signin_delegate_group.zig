/// An Active Directory (AD) group whose members are granted permission to act
/// as delegates.
pub const SigninDelegateGroup = struct {
    /// The group name.
    group_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .group_name = "GroupName",
    };
};
