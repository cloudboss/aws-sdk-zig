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
    beneficiary: ?[]const u8 = null,

    /// Configuration for consumption of the license.
    consumption_configuration: ?ConsumptionConfiguration = null,

    /// Creation time of the granted license.
    create_time: ?[]const u8 = null,

    /// License entitlements.
    entitlements: ?[]const Entitlement = null,

    /// Home Region of the granted license.
    home_region: ?[]const u8 = null,

    /// Granted license issuer.
    issuer: ?IssuerDetails = null,

    /// Amazon Resource Name (ARN) of the license.
    license_arn: ?[]const u8 = null,

    /// Granted license metadata.
    license_metadata: ?[]const Metadata = null,

    /// License name.
    license_name: ?[]const u8 = null,

    /// Product name.
    product_name: ?[]const u8 = null,

    /// Product SKU.
    product_sku: ?[]const u8 = null,

    /// Granted license received metadata.
    received_metadata: ?ReceivedMetadata = null,

    /// Granted license status.
    status: ?LicenseStatus = null,

    /// Date and time range during which the granted license is valid, in
    /// ISO8601-UTC format.
    validity: ?DatetimeRange = null,

    /// Version of the granted license.
    version: ?[]const u8 = null,

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
