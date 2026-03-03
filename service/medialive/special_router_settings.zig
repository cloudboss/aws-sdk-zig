/// When using MediaConnect Router as the source of a MediaLive input there's a
/// special handoff that occurs when a router output
/// is created. This group of settings is set on your behalf by the MediaConnect
/// Router service using this set of settings. This
/// setting object can only by used by that service.
pub const SpecialRouterSettings = struct {
    /// This is the arn of the MediaConnect Router resource being associated with
    /// the MediaLive Input.
    router_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .router_arn = "RouterArn",
    };
};
