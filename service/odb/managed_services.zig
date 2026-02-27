const CrossRegionS3RestoreSourcesAccess = @import("cross_region_s3_restore_sources_access.zig").CrossRegionS3RestoreSourcesAccess;
const KmsAccess = @import("kms_access.zig").KmsAccess;
const ManagedS3BackupAccess = @import("managed_s3_backup_access.zig").ManagedS3BackupAccess;
const S3Access = @import("s3_access.zig").S3Access;
const ServiceNetworkEndpoint = @import("service_network_endpoint.zig").ServiceNetworkEndpoint;
const StsAccess = @import("sts_access.zig").StsAccess;
const ZeroEtlAccess = @import("zero_etl_access.zig").ZeroEtlAccess;

/// The managed services configuration for the ODB network.
pub const ManagedServices = struct {
    /// The access configuration for the cross-Region Amazon S3 database restore
    /// source.
    cross_region_s3_restore_sources_access: ?[]const CrossRegionS3RestoreSourcesAccess,

    /// The Amazon Web Services Key Management Service (KMS) access configuration.
    kms_access: ?KmsAccess,

    /// The managed Amazon S3 backup access configuration.
    managed_s3_backup_access: ?ManagedS3BackupAccess,

    /// The IPv4 CIDR blocks for the managed services.
    managed_services_ipv_4_cidrs: ?[]const []const u8,

    /// The Amazon Resource Name (ARN) of the resource gateway.
    resource_gateway_arn: ?[]const u8,

    /// The Amazon S3 access configuration.
    s_3_access: ?S3Access,

    /// The Amazon Resource Name (ARN) of the service network.
    service_network_arn: ?[]const u8,

    /// The service network endpoint configuration.
    service_network_endpoint: ?ServiceNetworkEndpoint,

    /// The Amazon Web Services Security Token Service (STS) access configuration.
    sts_access: ?StsAccess,

    /// The Zero-ETL access configuration.
    zero_etl_access: ?ZeroEtlAccess,

    pub const json_field_names = .{
        .cross_region_s3_restore_sources_access = "crossRegionS3RestoreSourcesAccess",
        .kms_access = "kmsAccess",
        .managed_s3_backup_access = "managedS3BackupAccess",
        .managed_services_ipv_4_cidrs = "managedServicesIpv4Cidrs",
        .resource_gateway_arn = "resourceGatewayArn",
        .s_3_access = "s3Access",
        .service_network_arn = "serviceNetworkArn",
        .service_network_endpoint = "serviceNetworkEndpoint",
        .sts_access = "stsAccess",
        .zero_etl_access = "zeroEtlAccess",
    };
};
