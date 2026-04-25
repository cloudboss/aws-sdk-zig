/// A structure that contains the information about a service account token.
///
/// This structure is returned when creating the token. It is important to store
/// the `key` that is returned, as it is not retrievable at a later time.
///
/// If you lose the key, you can delete and recreate the token, which will
/// create a new key.
pub const ServiceAccountTokenSummaryWithKey = struct {
    /// The unique ID of the service account token.
    id: []const u8,

    /// The key for the service account token. Used when making calls to the Grafana
    /// HTTP APIs to authenticate and authorize the requests.
    key: []const u8,

    /// The name of the service account token.
    name: []const u8,

    pub const json_field_names = .{
        .id = "id",
        .key = "key",
        .name = "name",
    };
};
