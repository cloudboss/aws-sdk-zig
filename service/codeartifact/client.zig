const aws = @import("aws");
const std = @import("std");

const associate_external_connection = @import("associate_external_connection.zig");
const copy_package_versions = @import("copy_package_versions.zig");
const create_domain = @import("create_domain.zig");
const create_package_group = @import("create_package_group.zig");
const create_repository = @import("create_repository.zig");
const delete_domain = @import("delete_domain.zig");
const delete_domain_permissions_policy = @import("delete_domain_permissions_policy.zig");
const delete_package = @import("delete_package.zig");
const delete_package_group = @import("delete_package_group.zig");
const delete_package_versions = @import("delete_package_versions.zig");
const delete_repository = @import("delete_repository.zig");
const delete_repository_permissions_policy = @import("delete_repository_permissions_policy.zig");
const describe_domain = @import("describe_domain.zig");
const describe_package = @import("describe_package.zig");
const describe_package_group = @import("describe_package_group.zig");
const describe_package_version = @import("describe_package_version.zig");
const describe_repository = @import("describe_repository.zig");
const disassociate_external_connection = @import("disassociate_external_connection.zig");
const dispose_package_versions = @import("dispose_package_versions.zig");
const get_associated_package_group = @import("get_associated_package_group.zig");
const get_authorization_token = @import("get_authorization_token.zig");
const get_domain_permissions_policy = @import("get_domain_permissions_policy.zig");
const get_package_version_asset = @import("get_package_version_asset.zig");
const get_package_version_readme = @import("get_package_version_readme.zig");
const get_repository_endpoint = @import("get_repository_endpoint.zig");
const get_repository_permissions_policy = @import("get_repository_permissions_policy.zig");
const list_allowed_repositories_for_group = @import("list_allowed_repositories_for_group.zig");
const list_associated_packages = @import("list_associated_packages.zig");
const list_domains = @import("list_domains.zig");
const list_package_groups = @import("list_package_groups.zig");
const list_package_version_assets = @import("list_package_version_assets.zig");
const list_package_version_dependencies = @import("list_package_version_dependencies.zig");
const list_package_versions = @import("list_package_versions.zig");
const list_packages = @import("list_packages.zig");
const list_repositories = @import("list_repositories.zig");
const list_repositories_in_domain = @import("list_repositories_in_domain.zig");
const list_sub_package_groups = @import("list_sub_package_groups.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const publish_package_version = @import("publish_package_version.zig");
const put_domain_permissions_policy = @import("put_domain_permissions_policy.zig");
const put_package_origin_configuration = @import("put_package_origin_configuration.zig");
const put_repository_permissions_policy = @import("put_repository_permissions_policy.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_package_group = @import("update_package_group.zig");
const update_package_group_origin_configuration = @import("update_package_group_origin_configuration.zig");
const update_package_versions_status = @import("update_package_versions_status.zig");
const update_repository = @import("update_repository.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "codeartifact";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, .{ .retry_mode = config.retry_mode }),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, .{ .retry_mode = config.retry_mode, .request_options = options }),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Adds an existing external connection to a repository. One external
    /// connection is allowed
    /// per repository.
    ///
    /// A repository can have one or more upstream repositories, or an external
    /// connection.
    pub fn associateExternalConnection(self: *Self, allocator: std.mem.Allocator, input: associate_external_connection.AssociateExternalConnectionInput, options: associate_external_connection.Options) !associate_external_connection.AssociateExternalConnectionOutput {
        return associate_external_connection.execute(self, allocator, input, options);
    }

    /// Copies package versions from one repository to another repository in the
    /// same domain.
    ///
    /// You must specify `versions` or `versionRevisions`. You cannot specify both.
    pub fn copyPackageVersions(self: *Self, allocator: std.mem.Allocator, input: copy_package_versions.CopyPackageVersionsInput, options: copy_package_versions.Options) !copy_package_versions.CopyPackageVersionsOutput {
        return copy_package_versions.execute(self, allocator, input, options);
    }

    /// Creates a domain. CodeArtifact *domains* make it easier to manage multiple
    /// repositories across an
    /// organization. You can use a domain to apply permissions across many
    /// repositories owned by different Amazon Web Services accounts. An asset is
    /// stored only once
    /// in a domain, even if it's in multiple repositories.
    ///
    /// Although you can have multiple domains, we recommend a single production
    /// domain that contains all
    /// published artifacts so that your development teams can find and share
    /// packages. You can use a second
    /// pre-production domain to test changes to the production domain
    /// configuration.
    pub fn createDomain(self: *Self, allocator: std.mem.Allocator, input: create_domain.CreateDomainInput, options: create_domain.Options) !create_domain.CreateDomainOutput {
        return create_domain.execute(self, allocator, input, options);
    }

    /// Creates a package group. For more information about creating package groups,
    /// including example CLI commands, see [Create a package
    /// group](https://docs.aws.amazon.com/codeartifact/latest/ug/create-package-group.html) in the *CodeArtifact User Guide*.
    pub fn createPackageGroup(self: *Self, allocator: std.mem.Allocator, input: create_package_group.CreatePackageGroupInput, options: create_package_group.Options) !create_package_group.CreatePackageGroupOutput {
        return create_package_group.execute(self, allocator, input, options);
    }

    /// Creates a repository.
    pub fn createRepository(self: *Self, allocator: std.mem.Allocator, input: create_repository.CreateRepositoryInput, options: create_repository.Options) !create_repository.CreateRepositoryOutput {
        return create_repository.execute(self, allocator, input, options);
    }

    /// Deletes a domain. You cannot delete a domain that contains repositories. If
    /// you want to delete a domain
    /// with repositories, first delete its repositories.
    pub fn deleteDomain(self: *Self, allocator: std.mem.Allocator, input: delete_domain.DeleteDomainInput, options: delete_domain.Options) !delete_domain.DeleteDomainOutput {
        return delete_domain.execute(self, allocator, input, options);
    }

    /// Deletes the resource policy set on a domain.
    pub fn deleteDomainPermissionsPolicy(self: *Self, allocator: std.mem.Allocator, input: delete_domain_permissions_policy.DeleteDomainPermissionsPolicyInput, options: delete_domain_permissions_policy.Options) !delete_domain_permissions_policy.DeleteDomainPermissionsPolicyOutput {
        return delete_domain_permissions_policy.execute(self, allocator, input, options);
    }

    /// Deletes a package and all associated package versions. A deleted package
    /// cannot be restored. To delete one or more package versions, use the
    /// [DeletePackageVersions](https://docs.aws.amazon.com/codeartifact/latest/APIReference/API_DeletePackageVersions.html) API.
    pub fn deletePackage(self: *Self, allocator: std.mem.Allocator, input: delete_package.DeletePackageInput, options: delete_package.Options) !delete_package.DeletePackageOutput {
        return delete_package.execute(self, allocator, input, options);
    }

    /// Deletes a package group.
    /// Deleting a package group does not delete packages or package versions
    /// associated with the package group.
    /// When a package group is deleted, the direct child package groups will become
    /// children of the package
    /// group's direct parent package group. Therefore, if any of the child groups
    /// are inheriting any settings
    /// from the parent, those settings could change.
    pub fn deletePackageGroup(self: *Self, allocator: std.mem.Allocator, input: delete_package_group.DeletePackageGroupInput, options: delete_package_group.Options) !delete_package_group.DeletePackageGroupOutput {
        return delete_package_group.execute(self, allocator, input, options);
    }

    /// Deletes one or more versions of a package. A deleted package version cannot
    /// be restored
    /// in your repository. If you want to remove a package version from your
    /// repository and be able
    /// to restore it later, set its status to `Archived`. Archived packages cannot
    /// be
    /// downloaded from a repository and don't show up with list package APIs (for
    /// example,
    /// [ListPackageVersions](https://docs.aws.amazon.com/codeartifact/latest/APIReference/API_ListPackageVersions.html)), but you can restore them using [UpdatePackageVersionsStatus](https://docs.aws.amazon.com/codeartifact/latest/APIReference/API_UpdatePackageVersionsStatus.html).
    pub fn deletePackageVersions(self: *Self, allocator: std.mem.Allocator, input: delete_package_versions.DeletePackageVersionsInput, options: delete_package_versions.Options) !delete_package_versions.DeletePackageVersionsOutput {
        return delete_package_versions.execute(self, allocator, input, options);
    }

    /// Deletes a repository.
    pub fn deleteRepository(self: *Self, allocator: std.mem.Allocator, input: delete_repository.DeleteRepositoryInput, options: delete_repository.Options) !delete_repository.DeleteRepositoryOutput {
        return delete_repository.execute(self, allocator, input, options);
    }

    /// Deletes the resource policy that is set on a repository. After a resource
    /// policy is deleted, the
    /// permissions allowed and denied by the deleted policy are removed. The effect
    /// of deleting a resource policy might not be immediate.
    ///
    /// Use `DeleteRepositoryPermissionsPolicy` with caution. After a policy is
    /// deleted, Amazon Web Services users, roles, and accounts lose permissions to
    /// perform
    /// the repository actions granted by the deleted policy.
    pub fn deleteRepositoryPermissionsPolicy(self: *Self, allocator: std.mem.Allocator, input: delete_repository_permissions_policy.DeleteRepositoryPermissionsPolicyInput, options: delete_repository_permissions_policy.Options) !delete_repository_permissions_policy.DeleteRepositoryPermissionsPolicyOutput {
        return delete_repository_permissions_policy.execute(self, allocator, input, options);
    }

    /// Returns a
    /// [DomainDescription](https://docs.aws.amazon.com/codeartifact/latest/APIReference/API_DomainDescription.html)
    /// object that contains information about the requested domain.
    pub fn describeDomain(self: *Self, allocator: std.mem.Allocator, input: describe_domain.DescribeDomainInput, options: describe_domain.Options) !describe_domain.DescribeDomainOutput {
        return describe_domain.execute(self, allocator, input, options);
    }

    /// Returns a
    /// [PackageDescription](https://docs.aws.amazon.com/codeartifact/latest/APIReference/API_PackageDescription.html)
    /// object that contains information about the requested package.
    pub fn describePackage(self: *Self, allocator: std.mem.Allocator, input: describe_package.DescribePackageInput, options: describe_package.Options) !describe_package.DescribePackageOutput {
        return describe_package.execute(self, allocator, input, options);
    }

    /// Returns a
    /// [PackageGroupDescription](https://docs.aws.amazon.com/codeartifact/latest/APIReference/API_PackageGroupDescription.html) object that
    /// contains information about the requested package group.
    pub fn describePackageGroup(self: *Self, allocator: std.mem.Allocator, input: describe_package_group.DescribePackageGroupInput, options: describe_package_group.Options) !describe_package_group.DescribePackageGroupOutput {
        return describe_package_group.execute(self, allocator, input, options);
    }

    /// Returns a
    /// [PackageVersionDescription](https://docs.aws.amazon.com/codeartifact/latest/APIReference/API_PackageVersionDescription.html)
    /// object that contains information about the requested package version.
    pub fn describePackageVersion(self: *Self, allocator: std.mem.Allocator, input: describe_package_version.DescribePackageVersionInput, options: describe_package_version.Options) !describe_package_version.DescribePackageVersionOutput {
        return describe_package_version.execute(self, allocator, input, options);
    }

    /// Returns a `RepositoryDescription` object that contains detailed information
    /// about the requested repository.
    pub fn describeRepository(self: *Self, allocator: std.mem.Allocator, input: describe_repository.DescribeRepositoryInput, options: describe_repository.Options) !describe_repository.DescribeRepositoryOutput {
        return describe_repository.execute(self, allocator, input, options);
    }

    /// Removes an existing external connection from a repository.
    pub fn disassociateExternalConnection(self: *Self, allocator: std.mem.Allocator, input: disassociate_external_connection.DisassociateExternalConnectionInput, options: disassociate_external_connection.Options) !disassociate_external_connection.DisassociateExternalConnectionOutput {
        return disassociate_external_connection.execute(self, allocator, input, options);
    }

    /// Deletes the assets in package versions and sets the package versions' status
    /// to `Disposed`.
    /// A disposed package version cannot be restored in your repository because its
    /// assets are deleted.
    ///
    /// To view all disposed package versions in a repository, use
    /// [ListPackageVersions](https://docs.aws.amazon.com/codeartifact/latest/APIReference/API_ListPackageVersions.html) and set the
    /// [status](https://docs.aws.amazon.com/codeartifact/latest/APIReference/API_ListPackageVersions.html#API_ListPackageVersions_RequestSyntax) parameter
    /// to `Disposed`.
    ///
    /// To view information about a disposed package version, use
    /// [DescribePackageVersion](https://docs.aws.amazon.com/codeartifact/latest/APIReference/API_DescribePackageVersion.html).
    pub fn disposePackageVersions(self: *Self, allocator: std.mem.Allocator, input: dispose_package_versions.DisposePackageVersionsInput, options: dispose_package_versions.Options) !dispose_package_versions.DisposePackageVersionsOutput {
        return dispose_package_versions.execute(self, allocator, input, options);
    }

    /// Returns the most closely associated package group to the specified package.
    /// This API does not require that the package exist
    /// in any repository in the domain. As such, `GetAssociatedPackageGroup` can be
    /// used to see which package group's origin configuration
    /// applies to a package before that package is in a repository. This can be
    /// helpful to check if public packages are blocked without ingesting them.
    ///
    /// For information package group association and matching, see
    /// [Package group
    /// definition syntax and matching
    /// behavior](https://docs.aws.amazon.com/codeartifact/latest/ug/package-group-definition-syntax-matching-behavior.html) in the *CodeArtifact User Guide*.
    pub fn getAssociatedPackageGroup(self: *Self, allocator: std.mem.Allocator, input: get_associated_package_group.GetAssociatedPackageGroupInput, options: get_associated_package_group.Options) !get_associated_package_group.GetAssociatedPackageGroupOutput {
        return get_associated_package_group.execute(self, allocator, input, options);
    }

    /// Generates a temporary authorization token for accessing repositories in the
    /// domain.
    /// This API requires the `codeartifact:GetAuthorizationToken` and
    /// `sts:GetServiceBearerToken` permissions.
    /// For more information about authorization tokens, see
    /// [CodeArtifact authentication and
    /// tokens](https://docs.aws.amazon.com/codeartifact/latest/ug/tokens-authentication.html).
    ///
    /// CodeArtifact authorization tokens are valid for a period of 12 hours when
    /// created with the `login` command.
    /// You can call `login` periodically to refresh the token. When
    /// you create an authorization token with the `GetAuthorizationToken` API, you
    /// can set a custom authorization period,
    /// up to a maximum of 12 hours, with the `durationSeconds` parameter.
    ///
    /// The authorization period begins after `login`
    /// or `GetAuthorizationToken` is called. If `login` or `GetAuthorizationToken`
    /// is called while
    /// assuming a role, the token lifetime is independent of the maximum session
    /// duration
    /// of the role. For example, if you call `sts assume-role` and specify a
    /// session duration of 15 minutes, then
    /// generate a CodeArtifact authorization token, the token will be valid for the
    /// full authorization period
    /// even though this is longer than the 15-minute session duration.
    ///
    /// See
    /// [Using IAM
    /// Roles](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_use.html)
    /// for more information on controlling session duration.
    pub fn getAuthorizationToken(self: *Self, allocator: std.mem.Allocator, input: get_authorization_token.GetAuthorizationTokenInput, options: get_authorization_token.Options) !get_authorization_token.GetAuthorizationTokenOutput {
        return get_authorization_token.execute(self, allocator, input, options);
    }

    /// Returns the resource policy attached to the specified domain.
    ///
    /// The policy is a resource-based policy, not an identity-based policy. For
    /// more information, see
    /// [Identity-based policies
    /// and resource-based policies
    /// ](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_identity-vs-resource.html) in the *IAM User Guide*.
    pub fn getDomainPermissionsPolicy(self: *Self, allocator: std.mem.Allocator, input: get_domain_permissions_policy.GetDomainPermissionsPolicyInput, options: get_domain_permissions_policy.Options) !get_domain_permissions_policy.GetDomainPermissionsPolicyOutput {
        return get_domain_permissions_policy.execute(self, allocator, input, options);
    }

    /// Returns an asset (or file) that is in a package. For example, for a Maven
    /// package version, use
    /// `GetPackageVersionAsset` to download a `JAR` file, a `POM` file,
    /// or any other assets in the package version.
    pub fn getPackageVersionAsset(self: *Self, allocator: std.mem.Allocator, input: get_package_version_asset.GetPackageVersionAssetInput, options: get_package_version_asset.Options) !get_package_version_asset.GetPackageVersionAssetOutput {
        return get_package_version_asset.execute(self, allocator, input, options);
    }

    /// Gets the readme file or descriptive text for a package version.
    ///
    /// The returned text might contain formatting. For example, it might contain
    /// formatting for Markdown or reStructuredText.
    pub fn getPackageVersionReadme(self: *Self, allocator: std.mem.Allocator, input: get_package_version_readme.GetPackageVersionReadmeInput, options: get_package_version_readme.Options) !get_package_version_readme.GetPackageVersionReadmeOutput {
        return get_package_version_readme.execute(self, allocator, input, options);
    }

    /// Returns the endpoint of a repository for a specific package format. A
    /// repository has one endpoint for each
    /// package format:
    ///
    /// * `cargo`
    ///
    /// * `generic`
    ///
    /// * `maven`
    ///
    /// * `npm`
    ///
    /// * `nuget`
    ///
    /// * `pypi`
    ///
    /// * `ruby`
    ///
    /// * `swift`
    pub fn getRepositoryEndpoint(self: *Self, allocator: std.mem.Allocator, input: get_repository_endpoint.GetRepositoryEndpointInput, options: get_repository_endpoint.Options) !get_repository_endpoint.GetRepositoryEndpointOutput {
        return get_repository_endpoint.execute(self, allocator, input, options);
    }

    /// Returns the resource policy that is set on a repository.
    pub fn getRepositoryPermissionsPolicy(self: *Self, allocator: std.mem.Allocator, input: get_repository_permissions_policy.GetRepositoryPermissionsPolicyInput, options: get_repository_permissions_policy.Options) !get_repository_permissions_policy.GetRepositoryPermissionsPolicyOutput {
        return get_repository_permissions_policy.execute(self, allocator, input, options);
    }

    /// Lists the repositories in the added repositories list of the specified
    /// restriction type for a package group. For more information about restriction
    /// types
    /// and added repository lists, see [Package group origin
    /// controls](https://docs.aws.amazon.com/codeartifact/latest/ug/package-group-origin-controls.html) in the *CodeArtifact User Guide*.
    pub fn listAllowedRepositoriesForGroup(self: *Self, allocator: std.mem.Allocator, input: list_allowed_repositories_for_group.ListAllowedRepositoriesForGroupInput, options: list_allowed_repositories_for_group.Options) !list_allowed_repositories_for_group.ListAllowedRepositoriesForGroupOutput {
        return list_allowed_repositories_for_group.execute(self, allocator, input, options);
    }

    /// Returns a list of packages associated with the requested package group. For
    /// information package group association and matching, see
    /// [Package group
    /// definition syntax and matching
    /// behavior](https://docs.aws.amazon.com/codeartifact/latest/ug/package-group-definition-syntax-matching-behavior.html) in the *CodeArtifact User Guide*.
    pub fn listAssociatedPackages(self: *Self, allocator: std.mem.Allocator, input: list_associated_packages.ListAssociatedPackagesInput, options: list_associated_packages.Options) !list_associated_packages.ListAssociatedPackagesOutput {
        return list_associated_packages.execute(self, allocator, input, options);
    }

    /// Returns a list of
    /// [DomainSummary](https://docs.aws.amazon.com/codeartifact/latest/APIReference/API_PackageVersionDescription.html) objects for all domains owned by the Amazon Web Services account that makes
    /// this call. Each returned `DomainSummary` object contains information about a
    /// domain.
    pub fn listDomains(self: *Self, allocator: std.mem.Allocator, input: list_domains.ListDomainsInput, options: list_domains.Options) !list_domains.ListDomainsOutput {
        return list_domains.execute(self, allocator, input, options);
    }

    /// Returns a list of package groups in the requested domain.
    pub fn listPackageGroups(self: *Self, allocator: std.mem.Allocator, input: list_package_groups.ListPackageGroupsInput, options: list_package_groups.Options) !list_package_groups.ListPackageGroupsOutput {
        return list_package_groups.execute(self, allocator, input, options);
    }

    /// Returns a list of
    /// [AssetSummary](https://docs.aws.amazon.com/codeartifact/latest/APIReference/API_AssetSummary.html)
    /// objects for assets in a package version.
    pub fn listPackageVersionAssets(self: *Self, allocator: std.mem.Allocator, input: list_package_version_assets.ListPackageVersionAssetsInput, options: list_package_version_assets.Options) !list_package_version_assets.ListPackageVersionAssetsOutput {
        return list_package_version_assets.execute(self, allocator, input, options);
    }

    /// Returns the direct dependencies for a package version. The dependencies are
    /// returned as
    /// [PackageDependency](https://docs.aws.amazon.com/codeartifact/latest/APIReference/API_PackageDependency.html)
    /// objects. CodeArtifact extracts the dependencies for a package version from
    /// the metadata file for the package
    /// format (for example, the `package.json` file for npm packages and the
    /// `pom.xml` file
    /// for Maven). Any package version dependencies that are not listed in the
    /// configuration file are not returned.
    pub fn listPackageVersionDependencies(self: *Self, allocator: std.mem.Allocator, input: list_package_version_dependencies.ListPackageVersionDependenciesInput, options: list_package_version_dependencies.Options) !list_package_version_dependencies.ListPackageVersionDependenciesOutput {
        return list_package_version_dependencies.execute(self, allocator, input, options);
    }

    /// Returns a list of
    /// [PackageVersionSummary](https://docs.aws.amazon.com/codeartifact/latest/APIReference/API_PackageVersionSummary.html)
    /// objects for package versions in a repository that match the request
    /// parameters. Package versions of all statuses will be returned by default
    /// when calling `list-package-versions` with no `--status` parameter.
    pub fn listPackageVersions(self: *Self, allocator: std.mem.Allocator, input: list_package_versions.ListPackageVersionsInput, options: list_package_versions.Options) !list_package_versions.ListPackageVersionsOutput {
        return list_package_versions.execute(self, allocator, input, options);
    }

    /// Returns a list of
    /// [PackageSummary](https://docs.aws.amazon.com/codeartifact/latest/APIReference/API_PackageSummary.html)
    /// objects for packages in a repository that match the request parameters.
    pub fn listPackages(self: *Self, allocator: std.mem.Allocator, input: list_packages.ListPackagesInput, options: list_packages.Options) !list_packages.ListPackagesOutput {
        return list_packages.execute(self, allocator, input, options);
    }

    /// Returns a list of
    /// [RepositorySummary](https://docs.aws.amazon.com/codeartifact/latest/APIReference/API_RepositorySummary.html)
    /// objects. Each `RepositorySummary` contains information about a repository in
    /// the specified Amazon Web Services account and that matches the input
    /// parameters.
    pub fn listRepositories(self: *Self, allocator: std.mem.Allocator, input: list_repositories.ListRepositoriesInput, options: list_repositories.Options) !list_repositories.ListRepositoriesOutput {
        return list_repositories.execute(self, allocator, input, options);
    }

    /// Returns a list of
    /// [RepositorySummary](https://docs.aws.amazon.com/codeartifact/latest/APIReference/API_RepositorySummary.html)
    /// objects. Each `RepositorySummary` contains information about a repository in
    /// the specified domain and that matches the input
    /// parameters.
    pub fn listRepositoriesInDomain(self: *Self, allocator: std.mem.Allocator, input: list_repositories_in_domain.ListRepositoriesInDomainInput, options: list_repositories_in_domain.Options) !list_repositories_in_domain.ListRepositoriesInDomainOutput {
        return list_repositories_in_domain.execute(self, allocator, input, options);
    }

    /// Returns a list of direct children of the specified package group.
    ///
    /// For information package group hierarchy, see
    /// [Package group
    /// definition syntax and matching
    /// behavior](https://docs.aws.amazon.com/codeartifact/latest/ug/package-group-definition-syntax-matching-behavior.html) in the *CodeArtifact User Guide*.
    pub fn listSubPackageGroups(self: *Self, allocator: std.mem.Allocator, input: list_sub_package_groups.ListSubPackageGroupsInput, options: list_sub_package_groups.Options) !list_sub_package_groups.ListSubPackageGroupsOutput {
        return list_sub_package_groups.execute(self, allocator, input, options);
    }

    /// Gets information about Amazon Web Services tags for a specified Amazon
    /// Resource Name (ARN) in CodeArtifact.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Creates a new package version containing one or more assets (or files).
    ///
    /// The `unfinished` flag can be used to keep the package version in the
    /// `Unfinished` state until all of its assets have been uploaded (see [Package
    /// version
    /// status](https://docs.aws.amazon.com/codeartifact/latest/ug/packages-overview.html#package-version-status.html#package-version-status) in the *CodeArtifact user guide*). To set
    /// the package version’s status to `Published`, omit the `unfinished` flag
    /// when uploading the final asset, or set the status using
    /// [UpdatePackageVersionStatus](https://docs.aws.amazon.com/codeartifact/latest/APIReference/API_UpdatePackageVersionsStatus.html). Once a package version’s status is set to
    /// `Published`, it cannot change back to `Unfinished`.
    ///
    /// Only generic packages can be published using this API. For more information,
    /// see [Using generic
    /// packages](https://docs.aws.amazon.com/codeartifact/latest/ug/using-generic.html) in the *CodeArtifact User Guide*.
    pub fn publishPackageVersion(self: *Self, allocator: std.mem.Allocator, input: publish_package_version.PublishPackageVersionInput, options: publish_package_version.Options) !publish_package_version.PublishPackageVersionOutput {
        return publish_package_version.execute(self, allocator, input, options);
    }

    /// Sets a resource policy on a domain that specifies permissions to access it.
    ///
    /// When you call `PutDomainPermissionsPolicy`, the resource policy on the
    /// domain is ignored when evaluting permissions.
    /// This ensures that the owner of a domain cannot lock themselves out of the
    /// domain, which would prevent them from being
    /// able to update the resource policy.
    pub fn putDomainPermissionsPolicy(self: *Self, allocator: std.mem.Allocator, input: put_domain_permissions_policy.PutDomainPermissionsPolicyInput, options: put_domain_permissions_policy.Options) !put_domain_permissions_policy.PutDomainPermissionsPolicyOutput {
        return put_domain_permissions_policy.execute(self, allocator, input, options);
    }

    /// Sets the package origin configuration for a package.
    ///
    /// The package origin configuration determines how new versions of a package
    /// can be added to a repository. You can allow or block direct
    /// publishing of new package versions, or ingestion and retaining of new
    /// package versions from an external connection or upstream source.
    /// For more information about package origin controls and configuration, see
    /// [Editing package origin
    /// controls](https://docs.aws.amazon.com/codeartifact/latest/ug/package-origin-controls.html) in the *CodeArtifact User Guide*.
    ///
    /// `PutPackageOriginConfiguration` can be called on a package that doesn't yet
    /// exist in the repository. When called
    /// on a package that does not exist, a package is created in the repository
    /// with no versions and the requested restrictions are set on the package.
    /// This can be used to preemptively block ingesting or retaining any versions
    /// from external connections or upstream repositories, or to block
    /// publishing any versions of the package into the repository before connecting
    /// any package managers or publishers to the repository.
    pub fn putPackageOriginConfiguration(self: *Self, allocator: std.mem.Allocator, input: put_package_origin_configuration.PutPackageOriginConfigurationInput, options: put_package_origin_configuration.Options) !put_package_origin_configuration.PutPackageOriginConfigurationOutput {
        return put_package_origin_configuration.execute(self, allocator, input, options);
    }

    /// Sets the resource policy on a repository that specifies permissions to
    /// access it.
    ///
    /// When you call `PutRepositoryPermissionsPolicy`, the resource policy on the
    /// repository is ignored when evaluting permissions.
    /// This ensures that the owner of a repository cannot lock themselves out of
    /// the repository, which would prevent them from being
    /// able to update the resource policy.
    pub fn putRepositoryPermissionsPolicy(self: *Self, allocator: std.mem.Allocator, input: put_repository_permissions_policy.PutRepositoryPermissionsPolicyInput, options: put_repository_permissions_policy.Options) !put_repository_permissions_policy.PutRepositoryPermissionsPolicyOutput {
        return put_repository_permissions_policy.execute(self, allocator, input, options);
    }

    /// Adds or updates tags for a resource in CodeArtifact.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes tags from a resource in CodeArtifact.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates a package group. This API cannot be used to update a package group's
    /// origin configuration or pattern. To update a
    /// package group's origin configuration, use
    /// [UpdatePackageGroupOriginConfiguration](https://docs.aws.amazon.com/codeartifact/latest/APIReference/API_UpdatePackageGroupOriginConfiguration.html).
    pub fn updatePackageGroup(self: *Self, allocator: std.mem.Allocator, input: update_package_group.UpdatePackageGroupInput, options: update_package_group.Options) !update_package_group.UpdatePackageGroupOutput {
        return update_package_group.execute(self, allocator, input, options);
    }

    /// Updates the package origin configuration for a package group.
    ///
    /// The package origin configuration determines how new versions of a package
    /// can be added to a repository. You can allow or block direct
    /// publishing of new package versions, or ingestion and retaining of new
    /// package versions from an external connection or upstream source.
    /// For more information about package group origin controls and configuration,
    /// see
    /// [Package group origin
    /// controls](https://docs.aws.amazon.com/codeartifact/latest/ug/package-group-origin-controls.html)
    /// in the *CodeArtifact User Guide*.
    pub fn updatePackageGroupOriginConfiguration(self: *Self, allocator: std.mem.Allocator, input: update_package_group_origin_configuration.UpdatePackageGroupOriginConfigurationInput, options: update_package_group_origin_configuration.Options) !update_package_group_origin_configuration.UpdatePackageGroupOriginConfigurationOutput {
        return update_package_group_origin_configuration.execute(self, allocator, input, options);
    }

    /// Updates the status of one or more versions of a package. Using
    /// `UpdatePackageVersionsStatus`,
    /// you can update the status of package versions to `Archived`, `Published`, or
    /// `Unlisted`.
    /// To set the status of a package version to `Disposed`, use
    /// [DisposePackageVersions](https://docs.aws.amazon.com/codeartifact/latest/APIReference/API_DisposePackageVersions.html).
    pub fn updatePackageVersionsStatus(self: *Self, allocator: std.mem.Allocator, input: update_package_versions_status.UpdatePackageVersionsStatusInput, options: update_package_versions_status.Options) !update_package_versions_status.UpdatePackageVersionsStatusOutput {
        return update_package_versions_status.execute(self, allocator, input, options);
    }

    /// Update the properties of a repository.
    pub fn updateRepository(self: *Self, allocator: std.mem.Allocator, input: update_repository.UpdateRepositoryInput, options: update_repository.Options) !update_repository.UpdateRepositoryOutput {
        return update_repository.execute(self, allocator, input, options);
    }

    pub fn listAllowedRepositoriesForGroupPaginator(self: *Self, params: list_allowed_repositories_for_group.ListAllowedRepositoriesForGroupInput) paginator.ListAllowedRepositoriesForGroupPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAssociatedPackagesPaginator(self: *Self, params: list_associated_packages.ListAssociatedPackagesInput) paginator.ListAssociatedPackagesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDomainsPaginator(self: *Self, params: list_domains.ListDomainsInput) paginator.ListDomainsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPackageGroupsPaginator(self: *Self, params: list_package_groups.ListPackageGroupsInput) paginator.ListPackageGroupsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPackageVersionAssetsPaginator(self: *Self, params: list_package_version_assets.ListPackageVersionAssetsInput) paginator.ListPackageVersionAssetsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPackageVersionsPaginator(self: *Self, params: list_package_versions.ListPackageVersionsInput) paginator.ListPackageVersionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPackagesPaginator(self: *Self, params: list_packages.ListPackagesInput) paginator.ListPackagesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listRepositoriesPaginator(self: *Self, params: list_repositories.ListRepositoriesInput) paginator.ListRepositoriesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listRepositoriesInDomainPaginator(self: *Self, params: list_repositories_in_domain.ListRepositoriesInDomainInput) paginator.ListRepositoriesInDomainPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listSubPackageGroupsPaginator(self: *Self, params: list_sub_package_groups.ListSubPackageGroupsInput) paginator.ListSubPackageGroupsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
