const ParentType = @import("parent_type.zig").ParentType;

/// Contains information about either a root or an organizational unit (OU) that
/// can
/// contain OUs or accounts in an organization.
pub const Parent = struct {
    /// The unique identifier (ID) of the parent entity.
    ///
    /// The [regex pattern](http://wikipedia.org/wiki/regex) for a parent ID string
    /// requires one of the
    /// following:
    ///
    /// * **Root** - A string that begins with "r-" followed by from 4 to 32
    ///   lowercase letters or
    /// digits.
    ///
    /// * **Organizational unit (OU)** - A string that begins with "ou-" followed by
    ///   from 4 to 32
    /// lowercase letters or digits (the ID of the root that the OU is in). This
    /// string is followed by a second
    /// "-" dash and from 8 to 32 additional lowercase letters or digits.
    id: ?[]const u8,

    /// The type of the parent entity.
    @"type": ?ParentType,

    pub const json_field_names = .{
        .id = "Id",
        .@"type" = "Type",
    };
};
