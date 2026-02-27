const AdvertiseTrustStoreCaNamesEnum = @import("advertise_trust_store_ca_names_enum.zig").AdvertiseTrustStoreCaNamesEnum;
const TrustStoreAssociationStatusEnum = @import("trust_store_association_status_enum.zig").TrustStoreAssociationStatusEnum;

/// Information about the mutual authentication attributes of a listener.
pub const MutualAuthenticationAttributes = struct {
    /// Indicates whether trust store CA certificate names are advertised.
    advertise_trust_store_ca_names: ?AdvertiseTrustStoreCaNamesEnum,

    /// Indicates whether expired client certificates are ignored.
    ignore_client_certificate_expiry: ?bool,

    /// The client certificate handling method. Options are `off`,
    /// `passthrough` or `verify`. The default value is
    /// `off`.
    mode: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the trust store.
    trust_store_arn: ?[]const u8,

    /// Indicates a shared trust stores association status.
    trust_store_association_status: ?TrustStoreAssociationStatusEnum,
};
