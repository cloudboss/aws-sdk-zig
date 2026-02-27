const ConsumptionConfiguration = @import("consumption_configuration.zig").ConsumptionConfiguration;
const Entitlement = @import("entitlement.zig").Entitlement;
const IssuerDetails = @import("issuer_details.zig").IssuerDetails;
const Metadata = @import("metadata.zig").Metadata;
const LicenseStatus = @import("license_status.zig").LicenseStatus;
const DatetimeRange = @import("datetime_range.zig").DatetimeRange;

/// Software license that is managed in License Manager.
pub const License = struct {
    /// License beneficiary.
    beneficiary: ?[]const u8,

    /// Configuration for consumption of the license.
    consumption_configuration: ?ConsumptionConfiguration,

    /// License creation time.
    create_time: ?[]const u8,

    /// License entitlements.
    entitlements: ?[]const Entitlement,

    /// Home Region of the license.
    home_region: ?[]const u8,

    /// License issuer.
    issuer: ?IssuerDetails,

    /// Amazon Resource Name (ARN) of the license.
    license_arn: ?[]const u8,

    /// License metadata.
    license_metadata: ?[]const Metadata,

    /// License name.
    license_name: ?[]const u8,

    /// Product name.
    product_name: ?[]const u8,

    /// Product SKU.
    product_sku: ?[]const u8,

    /// License status.
    status: ?LicenseStatus,

    /// Date and time range during which the license is valid, in ISO8601-UTC
    /// format.
    validity: ?DatetimeRange,

    /// License version.
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
        .status = "Status",
        .validity = "Validity",
        .version = "Version",
    };
};
