const Site = @import("site.zig").Site;

pub const UpdateSiteResponse = struct {
    /// Information about the site.
    site: ?Site = null,

    pub const json_field_names = .{
        .site = "Site",
    };
};
