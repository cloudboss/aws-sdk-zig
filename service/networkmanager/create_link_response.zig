const Link = @import("link.zig").Link;

pub const CreateLinkResponse = struct {
    /// Information about the link.
    link: ?Link,

    pub const json_field_names = .{
        .link = "Link",
    };
};
