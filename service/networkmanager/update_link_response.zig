const Link = @import("link.zig").Link;

pub const UpdateLinkResponse = struct {
    /// Information about the link.
    link: ?Link,

    pub const json_field_names = .{
        .link = "Link",
    };
};
