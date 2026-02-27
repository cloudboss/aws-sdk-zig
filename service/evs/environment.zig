const Check = @import("check.zig").Check;
const ConnectivityInfo = @import("connectivity_info.zig").ConnectivityInfo;
const Secret = @import("secret.zig").Secret;
const EnvironmentState = @import("environment_state.zig").EnvironmentState;
const CheckResult = @import("check_result.zig").CheckResult;
const LicenseInfo = @import("license_info.zig").LicenseInfo;
const ServiceAccessSecurityGroups = @import("service_access_security_groups.zig").ServiceAccessSecurityGroups;
const VcfHostnames = @import("vcf_hostnames.zig").VcfHostnames;
const VcfVersion = @import("vcf_version.zig").VcfVersion;

/// An object that represents an Amazon EVS environment.
pub const Environment = struct {
    /// A check on the environment to identify instance health and VMware VCF
    /// licensing issues.
    checks: ?[]const Check,

    /// The connectivity configuration for the environment. Amazon EVS requires that
    /// you specify two route server peer IDs. During environment creation, the
    /// route server endpoints peer with the NSX uplink VLAN for connectivity to the
    /// NSX overlay network.
    connectivity_info: ?ConnectivityInfo,

    /// The date and time that the environment was created.
    created_at: ?i64,

    /// The VCF credentials that are stored as Amazon EVS managed secrets in Amazon
    /// Web Services Secrets Manager.
    ///
    /// Amazon EVS stores credentials that are needed to install vCenter Server,
    /// NSX, and SDDC Manager.
    credentials: ?[]const Secret,

    /// The Amazon Resource Name (ARN) that is associated with the environment.
    environment_arn: ?[]const u8,

    /// The unique ID for the environment.
    environment_id: ?[]const u8,

    /// The name of the environment.
    environment_name: ?[]const u8,

    /// The state of an environment.
    environment_state: ?EnvironmentState,

    /// Reports impaired functionality that stems from issues internal to the
    /// environment, such as impaired reachability.
    environment_status: ?CheckResult,

    /// The Amazon Web Services KMS key ID that Amazon Web Services Secrets Manager
    /// uses to encrypt secrets that are associated with the environment. These
    /// secrets contain the VCF credentials that are needed to install vCenter
    /// Server, NSX, and SDDC Manager.
    ///
    /// By default, Amazon EVS use the Amazon Web Services Secrets Manager managed
    /// key `aws/secretsmanager`. You can also specify a customer managed key.
    kms_key_id: ?[]const u8,

    /// The license information that Amazon EVS requires to create an environment.
    /// Amazon EVS requires two license keys: a VCF solution key and a vSAN license
    /// key. The VCF solution key must cover a minimum of 256 cores. The vSAN
    /// license key must provide at least 110 TiB of vSAN capacity.
    license_info: ?[]const LicenseInfo,

    /// The date and time that the environment was modified.
    modified_at: ?i64,

    /// The security groups that allow traffic between the Amazon EVS control plane
    /// and your VPC for service access. If a security group is not specified,
    /// Amazon EVS uses the default security group in your account for service
    /// access.
    service_access_security_groups: ?ServiceAccessSecurityGroups,

    /// The subnet that is used to establish connectivity between the Amazon EVS
    /// control plane and VPC. Amazon EVS uses this subnet to perform validations
    /// and create the environment.
    service_access_subnet_id: ?[]const u8,

    /// The Broadcom Site ID that is associated with your Amazon EVS environment.
    /// Amazon EVS uses the Broadcom Site ID that you provide to meet Broadcom VCF
    /// license usage reporting requirements for Amazon EVS.
    site_id: ?[]const u8,

    /// A detailed description of the `environmentState` of an environment.
    state_details: ?[]const u8,

    /// Customer confirmation that the customer has purchased and will continue to
    /// maintain the required number of VCF software licenses to cover all physical
    /// processor cores in the Amazon EVS environment. Information about your VCF
    /// software in Amazon EVS will be shared with Broadcom to verify license
    /// compliance. Amazon EVS does not validate license keys. To validate license
    /// keys, visit the Broadcom support portal.
    terms_accepted: ?bool,

    /// The DNS hostnames to be used by the VCF management appliances in your
    /// environment.
    ///
    /// For environment creation to be successful, each hostname entry must resolve
    /// to a domain name that you've registered in your DNS service of choice and
    /// configured in the DHCP option set of your VPC. DNS hostnames cannot be
    /// changed after environment creation has started.
    vcf_hostnames: ?VcfHostnames,

    /// The VCF version of the environment.
    vcf_version: ?VcfVersion,

    /// The VPC associated with the environment.
    vpc_id: ?[]const u8,

    pub const json_field_names = .{
        .checks = "checks",
        .connectivity_info = "connectivityInfo",
        .created_at = "createdAt",
        .credentials = "credentials",
        .environment_arn = "environmentArn",
        .environment_id = "environmentId",
        .environment_name = "environmentName",
        .environment_state = "environmentState",
        .environment_status = "environmentStatus",
        .kms_key_id = "kmsKeyId",
        .license_info = "licenseInfo",
        .modified_at = "modifiedAt",
        .service_access_security_groups = "serviceAccessSecurityGroups",
        .service_access_subnet_id = "serviceAccessSubnetId",
        .site_id = "siteId",
        .state_details = "stateDetails",
        .terms_accepted = "termsAccepted",
        .vcf_hostnames = "vcfHostnames",
        .vcf_version = "vcfVersion",
        .vpc_id = "vpcId",
    };
};
