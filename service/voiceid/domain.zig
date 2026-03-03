const DomainStatus = @import("domain_status.zig").DomainStatus;
const ServerSideEncryptionConfiguration = @import("server_side_encryption_configuration.zig").ServerSideEncryptionConfiguration;
const ServerSideEncryptionUpdateDetails = @import("server_side_encryption_update_details.zig").ServerSideEncryptionUpdateDetails;
const WatchlistDetails = @import("watchlist_details.zig").WatchlistDetails;

/// Contains all the information about a domain.
pub const Domain = struct {
    /// The Amazon Resource Name (ARN) for the domain.
    arn: ?[]const u8 = null,

    /// The timestamp of when the domain was created.
    created_at: ?i64 = null,

    /// The description of the domain.
    description: ?[]const u8 = null,

    /// The identifier of the domain.
    domain_id: ?[]const u8 = null,

    /// The current status of the domain.
    domain_status: ?DomainStatus = null,

    /// The name for the domain.
    name: ?[]const u8 = null,

    /// The server-side encryption configuration containing the KMS key
    /// identifier you want Voice ID to use to encrypt your data.
    server_side_encryption_configuration: ?ServerSideEncryptionConfiguration = null,

    /// Details about the most recent server-side encryption configuration update.
    /// When the
    /// server-side encryption configuration is changed, dependency on the old KMS
    /// key is removed through an asynchronous process. When this update is
    /// complete, the domain's data can only be accessed using the new KMS key.
    server_side_encryption_update_details: ?ServerSideEncryptionUpdateDetails = null,

    /// The timestamp of when the domain was last update.
    updated_at: ?i64 = null,

    /// The watchlist details of a domain. Contains the default watchlist ID of the
    /// domain.
    watchlist_details: ?WatchlistDetails = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .created_at = "CreatedAt",
        .description = "Description",
        .domain_id = "DomainId",
        .domain_status = "DomainStatus",
        .name = "Name",
        .server_side_encryption_configuration = "ServerSideEncryptionConfiguration",
        .server_side_encryption_update_details = "ServerSideEncryptionUpdateDetails",
        .updated_at = "UpdatedAt",
        .watchlist_details = "WatchlistDetails",
    };
};
