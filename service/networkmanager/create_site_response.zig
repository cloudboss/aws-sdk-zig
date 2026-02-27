const Site = @import("site.zig").Site;

pub const CreateSiteResponse = struct {
    /// Information about the site.
    site: ?Site,

    pub const json_field_names = .{
        .site = "Site",
    };
};
