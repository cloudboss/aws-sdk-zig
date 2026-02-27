const AwsMemberBusinessTitle = @import("aws_member_business_title.zig").AwsMemberBusinessTitle;

/// Represents an Amazon Web Services team member for the engagement. This
/// structure includes details such as name, email, and business title.
pub const AwsTeamMember = struct {
    /// Specifies the Amazon Web Services team member's business title and indicates
    /// their organizational role.
    business_title: ?AwsMemberBusinessTitle,

    /// Provides the Amazon Web Services team member's email address.
    email: ?[]const u8,

    /// Provides the Amazon Web Services team member's first name.
    first_name: ?[]const u8,

    /// Provides the Amazon Web Services team member's last name.
    last_name: ?[]const u8,

    pub const json_field_names = .{
        .business_title = "BusinessTitle",
        .email = "Email",
        .first_name = "FirstName",
        .last_name = "LastName",
    };
};
