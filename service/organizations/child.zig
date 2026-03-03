const ChildType = @import("child_type.zig").ChildType;

/// Contains a list of child entities, either OUs or accounts.
pub const Child = struct {
    /// The unique identifier (ID) of this child entity.
    ///
    /// The [regex pattern](http://wikipedia.org/wiki/regex) for a child ID string
    /// requires one of the
    /// following:
    ///
    /// * **Account** - A string that consists of exactly 12 digits.
    ///
    /// * **Organizational unit (OU)** - A string that begins with
    /// "ou-" followed by from 4 to 32 lowercase letters or digits (the ID of the
    /// root that
    /// contains the OU). This string is followed by a second "-" dash and from 8 to
    /// 32 additional
    /// lowercase letters or digits.
    id: ?[]const u8 = null,

    /// The type of this child entity.
    @"type": ?ChildType = null,

    pub const json_field_names = .{
        .id = "Id",
        .@"type" = "Type",
    };
};
