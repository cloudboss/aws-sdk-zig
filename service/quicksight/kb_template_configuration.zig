/// The template configuration for a knowledge base. This object contains
/// connector-specific configuration that defines how data is crawled and
/// indexed.
pub const KbTemplateConfiguration = struct {
    /// The connector configuration for the knowledge base data source. The
    /// structure depends on the connector type of the data source referenced by
    /// `DataSourceArn`.
    ///
    /// The template must be a JSON object. All connector types share the following
    /// top-level keys. The value of `type` and the contents of
    /// `connectionConfiguration` vary by connector type.
    ///
    /// * `type` – (Required) The connector type of the data source. This value
    ///   identifies the connector. Valid values: `S3V2`, `WEBCRAWLERV3`,
    ///   `GOOGLEDRIVEV3`, `ONEDRIVEV3`, `SHAREPOINTV3`. For the fields required by
    ///   each connector, see the connector-specific list that follows.
    ///
    /// * `connectionConfiguration` – (Required) The connection details for the data
    ///   source. The keys in this object vary by connector type; see the
    ///   connector-specific list that follows.
    ///
    /// * `filterConfiguration` – (Optional) Rules that determine which content is
    ///   crawled, such as inclusion and exclusion prefixes, patterns, or file-size
    ///   limits.
    ///
    /// * `accessControlConfiguration` – (Optional) Document-level access control
    ///   (ACL) settings. Supported by all connector types except Web Crawler
    ///   (`WEBCRAWLERV3`). The available fields depend on the connector type.
    ///
    /// * `deletionProtectionConfiguration` – (Optional) Deletion-protection
    ///   settings, supported by all connector types. Contains
    ///   `enableDeletionProtection` (Boolean) and `deletionProtectionThreshold`
    ///   (String; a value from 1 to 100).
    ///
    /// The following list describes the valid `type` value, the
    /// `connectionConfiguration` contents, and any connector-specific fields for
    /// each connector type:
    ///
    /// * **Amazon S3** (`type`: `S3V2`) – The `type` value must be `S3V2`.
    ///   `connectionConfiguration` is required and contains:
    ///
    /// * `bucketName` – (Required) The name of the Amazon S3 bucket to crawl. Type:
    ///   String. Length: 3–63 characters. Pattern:
    ///   `^[a-z0-9][.\-a-z0-9]{1,61}[a-z0-9]$`.
    ///
    /// * `bucketOwnerAccountId` – (Required) The ID of the AWS account that owns
    ///   the bucket. Type: String. Pattern: `^\d{12}$`.
    ///
    /// Amazon S3 supports the following optional `filterConfiguration` fields:
    ///
    /// * `inclusionPrefixes` or `exclusionPrefixes` – Amazon S3 key prefixes to
    ///   include or exclude. Type: Array of String. Up to 350 items, each 1–1,024
    ///   characters.
    ///
    /// * `inclusionPatterns` or `exclusionPatterns` – Patterns to include or
    ///   exclude objects. Type: Array of String. Up to 350 items, each 1–1,024
    ///   characters.
    ///
    /// * `maxFileSizeInMegaBytes` – The maximum size, in MB, of a file to ingest.
    ///   Type: String. Pattern: `^\d+$`.
    ///
    /// For Amazon S3, `accessControlConfiguration` supports the following fields:
    ///
    /// * `crawlAcl` – Specifies whether the connector crawls and enforces document
    ///   access control lists (ACLs). Type: Boolean. When set to `true`, provide
    ///   ACLs either in a global ACL configuration file
    ///   (`aclConfigurationFilePath`) or in per-document metadata files.
    ///
    /// * `aclConfigurationFilePath` – The Amazon S3 URI of the global ACL
    ///   configuration file. Type: String. Length: 1–1,024 characters. Optional. If
    ///   you don't provide a global ACL configuration file, define ACLs in
    ///   per-document metadata files.
    ///
    /// * `defaultAccessType` – The access behavior applied to Amazon S3 prefixes
    ///   that are not listed in the ACL configuration. Type: String. The only
    ///   supported value is `ALLOW`.
    ///
    /// `metadataFilesPrefix` – (Optional) The Amazon S3 prefix under which
    /// per-document metadata files are stored. Each metadata file describes a
    /// single source document and its indexable attributes. This is not the global
    /// ACL configuration file. For a single global ACL file, use
    /// `accessControlConfiguration.aclConfigurationFilePath`. Type: String. Length:
    /// 1–1,024 characters.
    ///
    /// * **Google Drive** (`type`: `GOOGLEDRIVEV3`) – Requires
    ///   `connectionConfiguration` with `authType` set to `SERVICE_ACCOUNT`.
    ///   Supports `dataEntityConfiguration` with `crawlMyDrive`,
    ///   `crawlSharedWithMe`, and `crawlSharedDrives`.
    ///
    /// * **OneDrive** (`type`: `ONEDRIVEV3`) – Requires `authType` at the template
    ///   root level set to `TWO_LEGGED_OAUTH`. Requires `connectionConfiguration`
    ///   with `tenantId` in UUID format. Supports `dataEntityConfiguration` with
    ///   `crawlPersonalDrives` and `crawlSharedWithMe`.
    ///
    /// * **SharePoint** (`type`: `SHAREPOINTV3`) – Requires
    ///   `connectionConfiguration` with `tenantId` in UUID format. Supports
    ///   `dataEntityConfiguration` with `siteUrls`, `crawlFiles`, and `crawlPages`.
    ///
    /// * **Web Crawler** (`type`: `WEBCRAWLERV3`) – Requires
    ///   `connectionConfiguration` with `seedUrls` or `siteMapUrls` (mutually
    ///   exclusive) and `authType`. Supports `crawlConfiguration` for crawl depth,
    ///   rate limits, and scope. Supports `filterConfiguration` for file size
    ///   limits and URL patterns. Valid values for `authType`: `NO_AUTH`,
    ///   `BASIC_AUTH`, `FORM`, `SAML`.
    ///
    /// **Enabling document-level access control for Amazon S3**
    ///
    /// For an Amazon S3 (`S3V2`) knowledge base, document-level access control is
    /// governed by two settings that must both be enabled:
    ///
    /// * In this template, set `accessControlConfiguration.crawlAcl` to `true`.
    ///   Define ACLs either in a global ACL configuration file, referenced by
    ///   `accessControlConfiguration.aclConfigurationFilePath`, or in per-document
    ///   metadata files. To control access for prefixes that are not listed in the
    ///   ACL file, you can also set `accessControlConfiguration.defaultAccessType`.
    ///
    /// * In the `CreateKnowledgeBase` or `UpdateKnowledgeBase` request, set the
    ///   top-level `AccessControlConfiguration.isACLEnabled` to `true`.
    template: ?[]const u8 = null,

    pub const json_field_names = .{
        .template = "template",
    };
};
