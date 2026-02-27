const DrmSystem = @import("drm_system.zig").DrmSystem;
const EncryptionContractConfiguration = @import("encryption_contract_configuration.zig").EncryptionContractConfiguration;

/// The parameters for the SPEKE key provider.
pub const SpekeKeyProvider = struct {
    /// The ARN for the certificate that you imported to AWS Certificate Manager to
    /// add content key encryption to this endpoint. For this feature to work, your
    /// DRM key provider must support content key encryption.
    certificate_arn: ?[]const u8,

    /// The DRM solution provider you're using to protect your content during
    /// distribution.
    drm_systems: []const DrmSystem,

    /// Configure one or more content encryption keys for your endpoints that use
    /// SPEKE Version 2.0. The encryption contract defines which content keys are
    /// used to encrypt the audio and video tracks in your stream. To configure the
    /// encryption contract, specify which audio and video encryption presets to
    /// use.
    encryption_contract_configuration: EncryptionContractConfiguration,

    /// The unique identifier for the content. The service sends this to the key
    /// server to identify the current endpoint. How unique you make this depends on
    /// how fine-grained you want access controls to be. The service does not permit
    /// you to use the same ID for two simultaneous encryption processes. The
    /// resource ID is also known as the content ID.
    ///
    /// The following example shows a resource ID: `MovieNight20171126093045`
    resource_id: []const u8,

    /// The ARN for the IAM role granted by the key provider that provides access to
    /// the key provider API. This role must have a trust policy that allows
    /// MediaPackage to assume the role, and it must have a sufficient permissions
    /// policy to allow access to the specific key retrieval URL. Get this from your
    /// DRM solution provider.
    ///
    /// Valid format: `arn:aws:iam::{accountID}:role/{name}`. The following example
    /// shows a role ARN: `arn:aws:iam::444455556666:role/SpekeAccess`
    role_arn: []const u8,

    /// The URL of the API Gateway proxy that you set up to talk to your key server.
    /// The API Gateway proxy must reside in the same AWS Region as MediaPackage and
    /// must start with https://.
    ///
    /// The following example shows a URL:
    /// `https://1wm2dx1f33.execute-api.us-west-2.amazonaws.com/SpekeSample/copyProtection`
    url: []const u8,

    pub const json_field_names = .{
        .certificate_arn = "CertificateArn",
        .drm_systems = "DrmSystems",
        .encryption_contract_configuration = "EncryptionContractConfiguration",
        .resource_id = "ResourceId",
        .role_arn = "RoleArn",
        .url = "Url",
    };
};
