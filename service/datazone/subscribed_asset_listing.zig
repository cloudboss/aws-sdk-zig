const AssetScope = @import("asset_scope.zig").AssetScope;
const DetailedGlossaryTerm = @import("detailed_glossary_term.zig").DetailedGlossaryTerm;
const Permissions = @import("permissions.zig").Permissions;

/// The details of the published asset for which the subscription grant is
/// created.
pub const SubscribedAssetListing = struct {
    /// The asset scope of the subscribed asset listing.
    asset_scope: ?AssetScope = null,

    /// The identifier of the published asset for which the subscription grant is
    /// created.
    entity_id: ?[]const u8 = null,

    /// The revision of the published asset for which the subscription grant is
    /// created.
    entity_revision: ?[]const u8 = null,

    /// The type of the published asset for which the subscription grant is created.
    entity_type: ?[]const u8 = null,

    /// The forms attached to the published asset for which the subscription grant
    /// is created.
    forms: ?[]const u8 = null,

    /// The glossary terms attached to the published asset for which the
    /// subscription grant is created.
    glossary_terms: ?[]const DetailedGlossaryTerm = null,

    /// The asset permissions.
    permissions: ?Permissions = null,

    pub const json_field_names = .{
        .asset_scope = "assetScope",
        .entity_id = "entityId",
        .entity_revision = "entityRevision",
        .entity_type = "entityType",
        .forms = "forms",
        .glossary_terms = "glossaryTerms",
        .permissions = "permissions",
    };
};
