const ContentKeyPeriodConfiguration = @import("content_key_period_configuration.zig").ContentKeyPeriodConfiguration;
const DrmSystem = @import("drm_system.zig").DrmSystem;
const EncryptionContractConfiguration = @import("encryption_contract_configuration.zig").EncryptionContractConfiguration;
const SpekeVersion = @import("speke_version.zig").SpekeVersion;

/// The parameters for the SPEKE key provider.
pub const SpekeKeyProvider = struct {
    /// The ARN for the certificate that you imported to Amazon Web Services
    /// Certificate Manager to add content key encryption to this endpoint. For this
    /// feature to work, your DRM key provider must support content key encryption.
    certificate_arn: ?[]const u8 = null,

    /// The configuration that controls whether MediaPackage signals the start and
    /// end times a content key is used for, in the `ContentKeyPeriod` sent to your
    /// DRM key provider. Signaling this timing is supported only when key rotation
    /// is enabled (`KeyRotationIntervalSeconds` is set to a non-zero value) and
    /// `SpekeVersion` is `V2_1`. You can update these settings on an existing
    /// origin endpoint.
    content_key_period_configuration: ?ContentKeyPeriodConfiguration = null,

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

    /// Specifies the SPEKE version used with your DRM key provider. If you don't
    /// specify a value, the default is `V2_0`.
    ///
    /// The allowed values are:
    ///
    /// * `V2_0` - Follows the SPEKE Version 2.0 contract and signals only the
    ///   content key index in key requests. This is the default.
    /// * `V2_1` - Follows the SPEKE Version 2.1 contract and additionally supports
    ///   signaling the start and end times a content key is used for, using
    ///   `ContentKeyPeriodConfiguration`.
    ///
    /// For more information, see [SPEKE Version 2.0
    /// payload](https://docs.aws.amazon.com/speke/latest/documentation/standard-payload-components-v2.html).
    speke_version: ?SpekeVersion = null,

    /// The URL of the API Gateway proxy that you set up to talk to your key server.
    /// The API Gateway proxy must reside in the same AWS Region as MediaPackage and
    /// must start with https://.
    ///
    /// The following example shows a URL:
    /// `https://1wm2dx1f33.execute-api.us-west-2.amazonaws.com/SpekeSample/copyProtection`
    url: []const u8,

    pub const json_field_names = .{
        .certificate_arn = "CertificateArn",
        .content_key_period_configuration = "ContentKeyPeriodConfiguration",
        .drm_systems = "DrmSystems",
        .encryption_contract_configuration = "EncryptionContractConfiguration",
        .resource_id = "ResourceId",
        .role_arn = "RoleArn",
        .speke_version = "SpekeVersion",
        .url = "Url",
    };
};
