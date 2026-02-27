/// Unique identifying information for an Apple app (iOS, macOS, tvOS and
/// watchOS). Consists of an Apple Bundle ID.
pub const AppleApp = struct {
    /// The unique identifier of the app across all Apple platforms (iOS, macOS,
    /// tvOS, watchOS, etc.)
    bundle_id: []const u8,

    pub const json_field_names = .{
        .bundle_id = "BundleId",
    };
};
