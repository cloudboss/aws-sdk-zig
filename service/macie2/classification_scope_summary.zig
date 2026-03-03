/// Provides information about the classification scope for an Amazon Macie
/// account. Macie uses the scope's settings when it performs automated
/// sensitive data discovery for the account.
pub const ClassificationScopeSummary = struct {
    /// The unique identifier for the classification scope.
    id: ?[]const u8 = null,

    /// The name of the classification scope: automated-sensitive-data-discovery.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .id = "id",
        .name = "name",
    };
};
