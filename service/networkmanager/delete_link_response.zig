const Link = @import("link.zig").Link;

pub const DeleteLinkResponse = struct {
    /// Information about the link.
    link: ?Link,

    pub const json_field_names = .{
        .link = "Link",
    };
};
