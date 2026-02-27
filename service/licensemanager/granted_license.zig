const ConsumptionConfiguration = @import("consumption_configuration.zig").ConsumptionConfiguration;
const Entitlement = @import("entitlement.zig").Entitlement;
const IssuerDetails = @import("issuer_details.zig").IssuerDetails;
const Metadata = @import("metadata.zig").Metadata;
const ReceivedMetadata = @import("received_metadata.zig").ReceivedMetadata;
const LicenseStatus = @import("license_status.zig").LicenseStatus;
const DatetimeRange = @import("datetime_range.zig").DatetimeRange;

/// Describes a license that is granted to a grantee.
pub const GrantedLicense = struct {
    /// Granted license beneficiary.
    beneficiary: ?[]const u8,

    /// Configuration for consumption of the license.
    consumption_configuration: ?ConsumptionConfiguration,

    /// Creation time of the granted license.
    create_time: ?[]const u8,

    /// License entitlements.
    entitlements: ?[]const Entitlement,

    /// Home Region of the granted license.
    home_region: ?[]const u8,

    /// Granted license issuer.
    issuer: ?IssuerDetails,

    /// Amazon Resource Name (ARN) of the license.
    license_arn: ?[]const u8,

    /// Granted license metadata.
    license_metadata: ?[]const Metadata,

    /// License name.
    license_name: ?[]const u8,

    /// Product name.
    product_name: ?[]const u8,

    /// Product SKU.
    product_sku: ?[]const u8,

    /// Granted license received metadata.
    received_metadata: ?ReceivedMetadata,

    /// Granted license status.
    status: ?LicenseStatus,

    /// Date and time range during which the granted license is valid, in
    /// ISO8601-UTC format.
    validity: ?DatetimeRange,

    /// Version of the granted license.
    version: ?[]const u8,

    pub const json_field_names = .{
        .beneficiary = "Beneficiary",
        .consumption_configuration = "ConsumptionConfiguration",
        .create_time = "CreateTime",
        .entitlements = "Entitlements",
        .home_region = "HomeRegion",
        .issuer = "Issuer",
        .license_arn = "LicenseArn",
        .license_metadata = "LicenseMetadata",
        .license_name = "LicenseName",
        .product_name = "ProductName",
        .product_sku = "ProductSKU",
        .received_metadata = "ReceivedMetadata",
        .status = "Status",
        .validity = "Validity",
        .version = "Version",
    };
};
