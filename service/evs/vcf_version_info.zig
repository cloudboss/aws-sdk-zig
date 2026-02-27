const InstanceType = @import("instance_type.zig").InstanceType;
const VcfVersion = @import("vcf_version.zig").VcfVersion;

/// Information about a VCF versions provided by Amazon EVS, including its
/// status, default ESX version, and EC2 instance types.
pub const VcfVersionInfo = struct {
    /// The default ESX version for this VCF version. It is based on Broadcom's Bill
    /// Of Materials (BOM).
    default_esx_version: []const u8,

    /// EC2 instance types provided by Amazon EVS for this VCF version for creating
    /// environments.
    instance_types: []const InstanceType,

    /// The status for this VCF version. Valid values are:
    ///
    /// * `AVAILABLE` - This VCF version is available to you.
    /// * `RESTRICTED` - This VCF version has limited availability.
    ///
    /// If the version you need shows RESTRICTED, and you require, check out [VCF
    /// versions and EC2 instance types provided by Amazon
    /// EVS](https://docs.aws.amazon.com/evs/latest/userguide/versions-provided.html) for more information.
    status: []const u8,

    /// The VCF version number.
    vcf_version: VcfVersion,

    pub const json_field_names = .{
        .default_esx_version = "defaultEsxVersion",
        .instance_types = "instanceTypes",
        .status = "status",
        .vcf_version = "vcfVersion",
    };
};
