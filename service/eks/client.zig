const aws = @import("aws");
const std = @import("std");

const associate_access_policy = @import("associate_access_policy.zig");
const associate_encryption_config = @import("associate_encryption_config.zig");
const associate_identity_provider_config = @import("associate_identity_provider_config.zig");
const create_access_entry = @import("create_access_entry.zig");
const create_addon = @import("create_addon.zig");
const create_capability = @import("create_capability.zig");
const create_cluster = @import("create_cluster.zig");
const create_eks_anywhere_subscription = @import("create_eks_anywhere_subscription.zig");
const create_fargate_profile = @import("create_fargate_profile.zig");
const create_nodegroup = @import("create_nodegroup.zig");
const create_pod_identity_association = @import("create_pod_identity_association.zig");
const delete_access_entry = @import("delete_access_entry.zig");
const delete_addon = @import("delete_addon.zig");
const delete_capability = @import("delete_capability.zig");
const delete_cluster = @import("delete_cluster.zig");
const delete_eks_anywhere_subscription = @import("delete_eks_anywhere_subscription.zig");
const delete_fargate_profile = @import("delete_fargate_profile.zig");
const delete_nodegroup = @import("delete_nodegroup.zig");
const delete_pod_identity_association = @import("delete_pod_identity_association.zig");
const deregister_cluster = @import("deregister_cluster.zig");
const describe_access_entry = @import("describe_access_entry.zig");
const describe_addon = @import("describe_addon.zig");
const describe_addon_configuration = @import("describe_addon_configuration.zig");
const describe_addon_versions = @import("describe_addon_versions.zig");
const describe_capability = @import("describe_capability.zig");
const describe_cluster = @import("describe_cluster.zig");
const describe_cluster_versions = @import("describe_cluster_versions.zig");
const describe_eks_anywhere_subscription = @import("describe_eks_anywhere_subscription.zig");
const describe_fargate_profile = @import("describe_fargate_profile.zig");
const describe_identity_provider_config = @import("describe_identity_provider_config.zig");
const describe_insight = @import("describe_insight.zig");
const describe_insights_refresh = @import("describe_insights_refresh.zig");
const describe_nodegroup = @import("describe_nodegroup.zig");
const describe_pod_identity_association = @import("describe_pod_identity_association.zig");
const describe_update = @import("describe_update.zig");
const disassociate_access_policy = @import("disassociate_access_policy.zig");
const disassociate_identity_provider_config = @import("disassociate_identity_provider_config.zig");
const list_access_entries = @import("list_access_entries.zig");
const list_access_policies = @import("list_access_policies.zig");
const list_addons = @import("list_addons.zig");
const list_associated_access_policies = @import("list_associated_access_policies.zig");
const list_capabilities = @import("list_capabilities.zig");
const list_clusters = @import("list_clusters.zig");
const list_eks_anywhere_subscriptions = @import("list_eks_anywhere_subscriptions.zig");
const list_fargate_profiles = @import("list_fargate_profiles.zig");
const list_identity_provider_configs = @import("list_identity_provider_configs.zig");
const list_insights = @import("list_insights.zig");
const list_nodegroups = @import("list_nodegroups.zig");
const list_pod_identity_associations = @import("list_pod_identity_associations.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const list_updates = @import("list_updates.zig");
const register_cluster = @import("register_cluster.zig");
const start_insights_refresh = @import("start_insights_refresh.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_access_entry = @import("update_access_entry.zig");
const update_addon = @import("update_addon.zig");
const update_capability = @import("update_capability.zig");
const update_cluster_config = @import("update_cluster_config.zig");
const update_cluster_version = @import("update_cluster_version.zig");
const update_eks_anywhere_subscription = @import("update_eks_anywhere_subscription.zig");
const update_nodegroup_config = @import("update_nodegroup_config.zig");
const update_nodegroup_version = @import("update_nodegroup_version.zig");
const update_pod_identity_association = @import("update_pod_identity_association.zig");
const paginator = @import("paginator.zig");
const waiters = @import("waiters.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "EKS";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, config.retry_mode),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.initWithOptions(allocator, config.retry_mode, options),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Associates an access policy and its scope to an access entry. For more
    /// information
    /// about associating access policies, see [Associating and disassociating
    /// access policies to and from access
    /// entries](https://docs.aws.amazon.com/eks/latest/userguide/access-policies.html) in the *Amazon EKS User Guide*.
    pub fn associateAccessPolicy(self: *Self, allocator: std.mem.Allocator, input: associate_access_policy.AssociateAccessPolicyInput, options: associate_access_policy.Options) !associate_access_policy.AssociateAccessPolicyOutput {
        return associate_access_policy.execute(self, allocator, input, options);
    }

    /// Associates an encryption configuration to an existing cluster.
    ///
    /// Use this API to enable encryption on existing clusters that don't already
    /// have
    /// encryption enabled. This allows you to implement a defense-in-depth security
    /// strategy
    /// without migrating applications to new Amazon EKS clusters.
    pub fn associateEncryptionConfig(self: *Self, allocator: std.mem.Allocator, input: associate_encryption_config.AssociateEncryptionConfigInput, options: associate_encryption_config.Options) !associate_encryption_config.AssociateEncryptionConfigOutput {
        return associate_encryption_config.execute(self, allocator, input, options);
    }

    /// Associates an identity provider configuration to a cluster.
    ///
    /// If you want to authenticate identities using an identity provider, you can
    /// create an
    /// identity provider configuration and associate it to your cluster. After
    /// configuring
    /// authentication to your cluster you can create Kubernetes `Role` and
    /// `ClusterRole` objects, assign permissions to them, and then bind them to
    /// the identities using Kubernetes `RoleBinding` and `ClusterRoleBinding`
    /// objects. For more information see [Using RBAC
    /// Authorization](https://kubernetes.io/docs/reference/access-authn-authz/rbac/) in the Kubernetes documentation.
    pub fn associateIdentityProviderConfig(self: *Self, allocator: std.mem.Allocator, input: associate_identity_provider_config.AssociateIdentityProviderConfigInput, options: associate_identity_provider_config.Options) !associate_identity_provider_config.AssociateIdentityProviderConfigOutput {
        return associate_identity_provider_config.execute(self, allocator, input, options);
    }

    /// Creates an access entry.
    ///
    /// An access entry allows an IAM principal to access your cluster. Access
    /// entries can replace the need to maintain entries in the `aws-auth`
    /// `ConfigMap` for authentication. You have the following options for
    /// authorizing an IAM principal to access Kubernetes objects on your cluster:
    /// Kubernetes
    /// role-based access control (RBAC), Amazon EKS, or both. Kubernetes RBAC
    /// authorization requires you
    /// to create and manage Kubernetes `Role`, `ClusterRole`,
    /// `RoleBinding`, and `ClusterRoleBinding` objects, in addition
    /// to managing access entries. If you use Amazon EKS authorization exclusively,
    /// you don't need
    /// to create and manage Kubernetes `Role`, `ClusterRole`,
    /// `RoleBinding`, and `ClusterRoleBinding` objects.
    ///
    /// For more information about access entries, see [Access
    /// entries](https://docs.aws.amazon.com/eks/latest/userguide/access-entries.html) in the
    /// *Amazon EKS User Guide*.
    pub fn createAccessEntry(self: *Self, allocator: std.mem.Allocator, input: create_access_entry.CreateAccessEntryInput, options: create_access_entry.Options) !create_access_entry.CreateAccessEntryOutput {
        return create_access_entry.execute(self, allocator, input, options);
    }

    /// Creates an Amazon EKS add-on.
    ///
    /// Amazon EKS add-ons help to automate the provisioning and lifecycle
    /// management of common
    /// operational software for Amazon EKS clusters. For more information, see
    /// [Amazon EKS
    /// add-ons](https://docs.aws.amazon.com/eks/latest/userguide/eks-add-ons.html)
    /// in the *Amazon EKS User Guide*.
    pub fn createAddon(self: *Self, allocator: std.mem.Allocator, input: create_addon.CreateAddonInput, options: create_addon.Options) !create_addon.CreateAddonOutput {
        return create_addon.execute(self, allocator, input, options);
    }

    /// Creates a managed capability resource for an Amazon EKS cluster.
    ///
    /// Capabilities provide fully managed capabilities to build and scale with
    /// Kubernetes. When you create a capability, Amazon EKSprovisions and manages
    /// the infrastructure required to run the capability outside of your cluster.
    /// This approach reduces operational overhead and preserves cluster resources.
    ///
    /// You can only create one Capability of each type on a given Amazon EKS
    /// cluster. Valid types are Argo CD for declarative GitOps deployment, Amazon
    /// Web Services Controllers for Kubernetes (ACK) for resource management, and
    /// Kube Resource Orchestrator (KRO) for Kubernetes custom resource
    /// orchestration.
    ///
    /// For more information, see [EKS
    /// Capabilities](https://docs.aws.amazon.com/eks/latest/userguide/capabilities.html) in the *Amazon EKS User Guide*.
    pub fn createCapability(self: *Self, allocator: std.mem.Allocator, input: create_capability.CreateCapabilityInput, options: create_capability.Options) !create_capability.CreateCapabilityOutput {
        return create_capability.execute(self, allocator, input, options);
    }

    /// Creates an Amazon EKS control plane.
    ///
    /// The Amazon EKS control plane consists of control plane instances that run
    /// the Kubernetes
    /// software, such as `etcd` and the API server. The control plane runs in an
    /// account managed by Amazon Web Services, and the Kubernetes API is exposed by
    /// the Amazon EKS API server endpoint.
    /// Each Amazon EKS cluster control plane is single tenant and unique. It runs
    /// on its own set of
    /// Amazon EC2 instances.
    ///
    /// The cluster control plane is provisioned across multiple Availability Zones
    /// and fronted by an Elastic Load Balancing
    /// Network Load Balancer. Amazon EKS also provisions elastic network interfaces
    /// in your VPC subnets to provide
    /// connectivity from the control plane instances to the nodes (for example, to
    /// support
    /// `kubectl exec`, `logs`, and `proxy` data
    /// flows).
    ///
    /// Amazon EKS nodes run in your Amazon Web Services account and connect to your
    /// cluster's control plane over
    /// the Kubernetes API server endpoint and a certificate file that is created
    /// for your
    /// cluster.
    ///
    /// You can use the `endpointPublicAccess` and
    /// `endpointPrivateAccess` parameters to enable or disable public and
    /// private access to your cluster's Kubernetes API server endpoint. By default,
    /// public access is
    /// enabled, and private access is disabled. The
    /// endpoint domain name and IP address family depends on the value of the
    /// `ipFamily` for the cluster. For more information, see [Amazon EKS Cluster
    /// Endpoint Access
    /// Control](https://docs.aws.amazon.com/eks/latest/userguide/cluster-endpoint.html) in the *
    /// Amazon EKS User Guide*
    /// .
    ///
    /// You can use the `logging` parameter to enable or disable exporting the
    /// Kubernetes control plane logs for your cluster to CloudWatch Logs. By
    /// default, cluster control plane
    /// logs aren't exported to CloudWatch Logs. For more information, see [Amazon
    /// EKS
    /// Cluster Control Plane
    /// Logs](https://docs.aws.amazon.com/eks/latest/userguide/control-plane-logs.html) in the
    /// *
    /// Amazon EKS User Guide*
    /// .
    ///
    /// CloudWatch Logs ingestion, archive storage, and data scanning rates apply to
    /// exported
    /// control plane logs. For more information, see [CloudWatch
    /// Pricing](http://aws.amazon.com/cloudwatch/pricing/).
    ///
    /// In most cases, it takes several minutes to create a cluster. After you
    /// create an Amazon EKS
    /// cluster, you must configure your Kubernetes tooling to communicate with the
    /// API server and
    /// launch nodes into your cluster. For more information, see [Allowing users to
    /// access your
    /// cluster](https://docs.aws.amazon.com/eks/latest/userguide/cluster-auth.html)
    /// and [Launching Amazon EKS
    /// nodes](https://docs.aws.amazon.com/eks/latest/userguide/launch-workers.html)
    /// in the *Amazon EKS User Guide*.
    pub fn createCluster(self: *Self, allocator: std.mem.Allocator, input: create_cluster.CreateClusterInput, options: create_cluster.Options) !create_cluster.CreateClusterOutput {
        return create_cluster.execute(self, allocator, input, options);
    }

    /// Creates an EKS Anywhere subscription. When a subscription is created, it is
    /// a contract
    /// agreement for the length of the term specified in the request. Licenses that
    /// are used to
    /// validate support are provisioned in Amazon Web Services License Manager and
    /// the caller account is
    /// granted access to EKS Anywhere Curated Packages.
    pub fn createEksAnywhereSubscription(self: *Self, allocator: std.mem.Allocator, input: create_eks_anywhere_subscription.CreateEksAnywhereSubscriptionInput, options: create_eks_anywhere_subscription.Options) !create_eks_anywhere_subscription.CreateEksAnywhereSubscriptionOutput {
        return create_eks_anywhere_subscription.execute(self, allocator, input, options);
    }

    /// Creates an Fargate profile for your Amazon EKS cluster. You must have at
    /// least one
    /// Fargate profile in a cluster to be able to run pods on Fargate.
    ///
    /// The Fargate profile allows an administrator to declare which pods run on
    /// Fargate
    /// and specify which pods run on which Fargate profile. This declaration is
    /// done through
    /// the profile's selectors. Each profile can have up to five selectors that
    /// contain a
    /// namespace and labels. A namespace is required for every selector. The label
    /// field
    /// consists of multiple optional key-value pairs. Pods that match the selectors
    /// are
    /// scheduled on Fargate. If a to-be-scheduled pod matches any of the selectors
    /// in the
    /// Fargate profile, then that pod is run on Fargate.
    ///
    /// When you create a Fargate profile, you must specify a pod execution role to
    /// use with
    /// the pods that are scheduled with the profile. This role is added to the
    /// cluster's Kubernetes
    /// [Role
    /// Based Access
    /// Control](https://kubernetes.io/docs/reference/access-authn-authz/rbac/)
    /// (RBAC) for authorization so that the
    /// `kubelet` that is running on the Fargate infrastructure can register
    /// with your Amazon EKS cluster so that it can appear in your cluster as a
    /// node. The pod
    /// execution role also provides IAM permissions to the Fargate infrastructure
    /// to allow
    /// read access to Amazon ECR image repositories. For more information, see [Pod
    /// Execution
    /// Role](https://docs.aws.amazon.com/eks/latest/userguide/pod-execution-role.html) in the *Amazon EKS User Guide*.
    ///
    /// Fargate profiles are immutable. However, you can create a new updated
    /// profile to
    /// replace an existing profile and then delete the original after the updated
    /// profile has
    /// finished creating.
    ///
    /// If any Fargate profiles in a cluster are in the `DELETING` status, you
    /// must wait for that Fargate profile to finish deleting before you can create
    /// any other
    /// profiles in that cluster.
    ///
    /// For more information, see [Fargate
    /// profile](https://docs.aws.amazon.com/eks/latest/userguide/fargate-profile.html) in the *Amazon EKS User Guide*.
    pub fn createFargateProfile(self: *Self, allocator: std.mem.Allocator, input: create_fargate_profile.CreateFargateProfileInput, options: create_fargate_profile.Options) !create_fargate_profile.CreateFargateProfileOutput {
        return create_fargate_profile.execute(self, allocator, input, options);
    }

    /// Creates a managed node group for an Amazon EKS cluster.
    ///
    /// You can only create a node group for your cluster that is equal to the
    /// current Kubernetes
    /// version for the cluster. All node groups are created with the latest AMI
    /// release version
    /// for the respective minor Kubernetes version of the cluster, unless you
    /// deploy a custom AMI
    /// using a launch template.
    ///
    /// For later updates, you will only be able to update a node group using a
    /// launch
    /// template only if it was originally deployed with a launch template.
    /// Additionally, the
    /// launch template ID or name must match what was used when the node group was
    /// created. You
    /// can update the launch template version with necessary changes. For more
    /// information
    /// about using launch templates, see [Customizing managed nodes with
    /// launch
    /// templates](https://docs.aws.amazon.com/eks/latest/userguide/launch-templates.html).
    ///
    /// An Amazon EKS managed node group is an Amazon EC2 Auto Scaling group and
    /// associated Amazon EC2 instances that
    /// are managed by Amazon Web Services for an Amazon EKS cluster. For more
    /// information, see [Managed
    /// node
    /// groups](https://docs.aws.amazon.com/eks/latest/userguide/managed-node-groups.html) in the *Amazon EKS User Guide*.
    ///
    /// Windows AMI types are only supported for commercial Amazon Web Services
    /// Regions that support
    /// Windows on Amazon EKS.
    pub fn createNodegroup(self: *Self, allocator: std.mem.Allocator, input: create_nodegroup.CreateNodegroupInput, options: create_nodegroup.Options) !create_nodegroup.CreateNodegroupOutput {
        return create_nodegroup.execute(self, allocator, input, options);
    }

    /// Creates an EKS Pod Identity association between a service account in an
    /// Amazon EKS cluster and an IAM role
    /// with *EKS Pod Identity*. Use EKS Pod Identity to give temporary IAM
    /// credentials to
    /// Pods and the credentials are rotated automatically.
    ///
    /// Amazon EKS Pod Identity associations provide the ability to manage
    /// credentials for your applications, similar to the way that Amazon EC2
    /// instance profiles provide credentials to Amazon EC2 instances.
    ///
    /// If a Pod uses a service account that has an association, Amazon EKS sets
    /// environment variables
    /// in the containers of the Pod. The environment variables configure the Amazon
    /// Web Services SDKs,
    /// including the Command Line Interface, to use the EKS Pod Identity
    /// credentials.
    ///
    /// EKS Pod Identity is a simpler method than *IAM roles for service
    /// accounts*, as this method doesn't use OIDC identity providers.
    /// Additionally, you can configure a role for EKS Pod Identity once, and reuse
    /// it across
    /// clusters.
    ///
    /// Similar to Amazon Web Services IAM behavior, EKS Pod Identity associations
    /// are eventually consistent,
    /// and may take several seconds to be effective after the initial API call
    /// returns
    /// successfully. You must design your applications to account for these
    /// potential delays.
    /// We recommend that you don’t include association create/updates in the
    /// critical, high-availability code paths of your application. Instead, make
    /// changes in a
    /// separate initialization or setup routine that you run less frequently.
    ///
    /// You can set a *target IAM role* in the same or a different
    /// account for advanced scenarios. With a target role, EKS Pod Identity
    /// automatically performs two
    /// role assumptions in sequence: first assuming the role in the association
    /// that is in this
    /// account, then using those credentials to assume the target IAM role. This
    /// process
    /// provides your Pod with temporary credentials that have the permissions
    /// defined in the
    /// target role, allowing secure access to resources in another Amazon Web
    /// Services account.
    pub fn createPodIdentityAssociation(self: *Self, allocator: std.mem.Allocator, input: create_pod_identity_association.CreatePodIdentityAssociationInput, options: create_pod_identity_association.Options) !create_pod_identity_association.CreatePodIdentityAssociationOutput {
        return create_pod_identity_association.execute(self, allocator, input, options);
    }

    /// Deletes an access entry.
    ///
    /// Deleting an access entry of a type other than `Standard` can cause your
    /// cluster to function improperly. If you delete an access entry in error, you
    /// can recreate
    /// it.
    pub fn deleteAccessEntry(self: *Self, allocator: std.mem.Allocator, input: delete_access_entry.DeleteAccessEntryInput, options: delete_access_entry.Options) !delete_access_entry.DeleteAccessEntryOutput {
        return delete_access_entry.execute(self, allocator, input, options);
    }

    /// Deletes an Amazon EKS add-on.
    ///
    /// When you remove an add-on, it's deleted from the cluster. You can always
    /// manually
    /// start an add-on on the cluster using the Kubernetes API.
    pub fn deleteAddon(self: *Self, allocator: std.mem.Allocator, input: delete_addon.DeleteAddonInput, options: delete_addon.Options) !delete_addon.DeleteAddonOutput {
        return delete_addon.execute(self, allocator, input, options);
    }

    /// Deletes a managed capability from your Amazon EKS cluster. When you delete a
    /// capability, Amazon EKS removes the capability infrastructure but retains all
    /// resources that were managed by the capability.
    ///
    /// Before deleting a capability, you should delete all Kubernetes resources
    /// that were created by the capability. After the capability is deleted, these
    /// resources become difficult to manage because the controller that managed
    /// them is no longer available. To delete resources before removing the
    /// capability, use `kubectl delete` or remove them through your GitOps
    /// workflow.
    pub fn deleteCapability(self: *Self, allocator: std.mem.Allocator, input: delete_capability.DeleteCapabilityInput, options: delete_capability.Options) !delete_capability.DeleteCapabilityOutput {
        return delete_capability.execute(self, allocator, input, options);
    }

    /// Deletes an Amazon EKS cluster control plane.
    ///
    /// If you have active services and ingress resources in your cluster that are
    /// associated with a load balancer,
    /// you must delete those services before deleting the cluster so that the load
    /// balancers
    /// are deleted properly. Otherwise, you can have orphaned resources in your VPC
    /// that
    /// prevent you from being able to delete the VPC. For more information, see
    /// [Deleting a
    /// cluster](https://docs.aws.amazon.com/eks/latest/userguide/delete-cluster.html) in the *Amazon EKS User Guide*.
    ///
    /// If you have managed node groups or Fargate profiles attached to the cluster,
    /// you
    /// must delete them first. For more information, see `DeleteNodgroup` and
    /// `DeleteFargateProfile`.
    pub fn deleteCluster(self: *Self, allocator: std.mem.Allocator, input: delete_cluster.DeleteClusterInput, options: delete_cluster.Options) !delete_cluster.DeleteClusterOutput {
        return delete_cluster.execute(self, allocator, input, options);
    }

    /// Deletes an expired or inactive subscription. Deleting inactive subscriptions
    /// removes
    /// them from the Amazon Web Services Management Console view and from
    /// list/describe API responses. Subscriptions can
    /// only be cancelled within 7 days of creation and are cancelled by creating a
    /// ticket in
    /// the Amazon Web Services Support Center.
    pub fn deleteEksAnywhereSubscription(self: *Self, allocator: std.mem.Allocator, input: delete_eks_anywhere_subscription.DeleteEksAnywhereSubscriptionInput, options: delete_eks_anywhere_subscription.Options) !delete_eks_anywhere_subscription.DeleteEksAnywhereSubscriptionOutput {
        return delete_eks_anywhere_subscription.execute(self, allocator, input, options);
    }

    /// Deletes an Fargate profile.
    ///
    /// When you delete a Fargate profile, any `Pod` running on Fargate that
    /// was created with the profile is deleted. If the `Pod` matches another
    /// Fargate profile, then it is scheduled on Fargate with that profile. If it no
    /// longer
    /// matches any Fargate profiles, then it's not scheduled on Fargate and may
    /// remain in a
    /// pending state.
    ///
    /// Only one Fargate profile in a cluster can be in the `DELETING` status at
    /// a time. You must wait for a Fargate profile to finish deleting before you
    /// can delete
    /// any other profiles in that cluster.
    pub fn deleteFargateProfile(self: *Self, allocator: std.mem.Allocator, input: delete_fargate_profile.DeleteFargateProfileInput, options: delete_fargate_profile.Options) !delete_fargate_profile.DeleteFargateProfileOutput {
        return delete_fargate_profile.execute(self, allocator, input, options);
    }

    /// Deletes a managed node group.
    pub fn deleteNodegroup(self: *Self, allocator: std.mem.Allocator, input: delete_nodegroup.DeleteNodegroupInput, options: delete_nodegroup.Options) !delete_nodegroup.DeleteNodegroupOutput {
        return delete_nodegroup.execute(self, allocator, input, options);
    }

    /// Deletes a EKS Pod Identity association.
    ///
    /// The temporary Amazon Web Services credentials from the previous IAM role
    /// session might still be valid until the session expiry. If you need to
    /// immediately revoke the temporary session credentials, then go to the role in
    /// the IAM console.
    pub fn deletePodIdentityAssociation(self: *Self, allocator: std.mem.Allocator, input: delete_pod_identity_association.DeletePodIdentityAssociationInput, options: delete_pod_identity_association.Options) !delete_pod_identity_association.DeletePodIdentityAssociationOutput {
        return delete_pod_identity_association.execute(self, allocator, input, options);
    }

    /// Deregisters a connected cluster to remove it from the Amazon EKS control
    /// plane.
    ///
    /// A connected cluster is a Kubernetes cluster that you've connected to your
    /// control plane
    /// using the [Amazon EKS
    /// Connector](https://docs.aws.amazon.com/eks/latest/userguide/eks-connector.html).
    pub fn deregisterCluster(self: *Self, allocator: std.mem.Allocator, input: deregister_cluster.DeregisterClusterInput, options: deregister_cluster.Options) !deregister_cluster.DeregisterClusterOutput {
        return deregister_cluster.execute(self, allocator, input, options);
    }

    /// Describes an access entry.
    pub fn describeAccessEntry(self: *Self, allocator: std.mem.Allocator, input: describe_access_entry.DescribeAccessEntryInput, options: describe_access_entry.Options) !describe_access_entry.DescribeAccessEntryOutput {
        return describe_access_entry.execute(self, allocator, input, options);
    }

    /// Describes an Amazon EKS add-on.
    pub fn describeAddon(self: *Self, allocator: std.mem.Allocator, input: describe_addon.DescribeAddonInput, options: describe_addon.Options) !describe_addon.DescribeAddonOutput {
        return describe_addon.execute(self, allocator, input, options);
    }

    /// Returns configuration options.
    pub fn describeAddonConfiguration(self: *Self, allocator: std.mem.Allocator, input: describe_addon_configuration.DescribeAddonConfigurationInput, options: describe_addon_configuration.Options) !describe_addon_configuration.DescribeAddonConfigurationOutput {
        return describe_addon_configuration.execute(self, allocator, input, options);
    }

    /// Describes the versions for an add-on.
    ///
    /// Information such as the Kubernetes versions that you can use the add-on
    /// with, the
    /// `owner`, `publisher`, and the `type` of the add-on
    /// are returned.
    pub fn describeAddonVersions(self: *Self, allocator: std.mem.Allocator, input: describe_addon_versions.DescribeAddonVersionsInput, options: describe_addon_versions.Options) !describe_addon_versions.DescribeAddonVersionsOutput {
        return describe_addon_versions.execute(self, allocator, input, options);
    }

    /// Returns detailed information about a specific managed capability in your
    /// Amazon EKS cluster, including its current status, configuration, health
    /// information, and any issues that may be affecting its operation.
    pub fn describeCapability(self: *Self, allocator: std.mem.Allocator, input: describe_capability.DescribeCapabilityInput, options: describe_capability.Options) !describe_capability.DescribeCapabilityOutput {
        return describe_capability.execute(self, allocator, input, options);
    }

    /// Describes an Amazon EKS cluster.
    ///
    /// The API server endpoint and certificate authority data returned by this
    /// operation are
    /// required for `kubelet` and `kubectl` to communicate with your
    /// Kubernetes API server. For more information, see [Creating or
    /// updating a `kubeconfig` file for an Amazon EKS
    /// cluster](https://docs.aws.amazon.com/eks/latest/userguide/create-kubeconfig.html).
    ///
    /// The API server endpoint and certificate authority data aren't available
    /// until the
    /// cluster reaches the `ACTIVE` state.
    pub fn describeCluster(self: *Self, allocator: std.mem.Allocator, input: describe_cluster.DescribeClusterInput, options: describe_cluster.Options) !describe_cluster.DescribeClusterOutput {
        return describe_cluster.execute(self, allocator, input, options);
    }

    /// Lists available Kubernetes versions for Amazon EKS clusters.
    pub fn describeClusterVersions(self: *Self, allocator: std.mem.Allocator, input: describe_cluster_versions.DescribeClusterVersionsInput, options: describe_cluster_versions.Options) !describe_cluster_versions.DescribeClusterVersionsOutput {
        return describe_cluster_versions.execute(self, allocator, input, options);
    }

    /// Returns descriptive information about a subscription.
    pub fn describeEksAnywhereSubscription(self: *Self, allocator: std.mem.Allocator, input: describe_eks_anywhere_subscription.DescribeEksAnywhereSubscriptionInput, options: describe_eks_anywhere_subscription.Options) !describe_eks_anywhere_subscription.DescribeEksAnywhereSubscriptionOutput {
        return describe_eks_anywhere_subscription.execute(self, allocator, input, options);
    }

    /// Describes an Fargate profile.
    pub fn describeFargateProfile(self: *Self, allocator: std.mem.Allocator, input: describe_fargate_profile.DescribeFargateProfileInput, options: describe_fargate_profile.Options) !describe_fargate_profile.DescribeFargateProfileOutput {
        return describe_fargate_profile.execute(self, allocator, input, options);
    }

    /// Describes an identity provider configuration.
    pub fn describeIdentityProviderConfig(self: *Self, allocator: std.mem.Allocator, input: describe_identity_provider_config.DescribeIdentityProviderConfigInput, options: describe_identity_provider_config.Options) !describe_identity_provider_config.DescribeIdentityProviderConfigOutput {
        return describe_identity_provider_config.execute(self, allocator, input, options);
    }

    /// Returns details about an insight that you specify using its ID.
    pub fn describeInsight(self: *Self, allocator: std.mem.Allocator, input: describe_insight.DescribeInsightInput, options: describe_insight.Options) !describe_insight.DescribeInsightOutput {
        return describe_insight.execute(self, allocator, input, options);
    }

    /// Returns the status of the latest on-demand cluster insights refresh
    /// operation.
    pub fn describeInsightsRefresh(self: *Self, allocator: std.mem.Allocator, input: describe_insights_refresh.DescribeInsightsRefreshInput, options: describe_insights_refresh.Options) !describe_insights_refresh.DescribeInsightsRefreshOutput {
        return describe_insights_refresh.execute(self, allocator, input, options);
    }

    /// Describes a managed node group.
    pub fn describeNodegroup(self: *Self, allocator: std.mem.Allocator, input: describe_nodegroup.DescribeNodegroupInput, options: describe_nodegroup.Options) !describe_nodegroup.DescribeNodegroupOutput {
        return describe_nodegroup.execute(self, allocator, input, options);
    }

    /// Returns descriptive information about an EKS Pod Identity association.
    ///
    /// This action requires the ID of the association. You can get the ID from the
    /// response to
    /// the `CreatePodIdentityAssocation` for newly created associations. Or, you
    /// can
    /// list the IDs for associations with `ListPodIdentityAssociations` and filter
    /// the
    /// list by namespace or service account.
    pub fn describePodIdentityAssociation(self: *Self, allocator: std.mem.Allocator, input: describe_pod_identity_association.DescribePodIdentityAssociationInput, options: describe_pod_identity_association.Options) !describe_pod_identity_association.DescribePodIdentityAssociationOutput {
        return describe_pod_identity_association.execute(self, allocator, input, options);
    }

    /// Describes an update to an Amazon EKS resource.
    ///
    /// When the status of the update is `Successful`, the update is complete. If
    /// an update fails, the status is `Failed`, and an error detail explains the
    /// reason for the failure.
    pub fn describeUpdate(self: *Self, allocator: std.mem.Allocator, input: describe_update.DescribeUpdateInput, options: describe_update.Options) !describe_update.DescribeUpdateOutput {
        return describe_update.execute(self, allocator, input, options);
    }

    /// Disassociates an access policy from an access entry.
    pub fn disassociateAccessPolicy(self: *Self, allocator: std.mem.Allocator, input: disassociate_access_policy.DisassociateAccessPolicyInput, options: disassociate_access_policy.Options) !disassociate_access_policy.DisassociateAccessPolicyOutput {
        return disassociate_access_policy.execute(self, allocator, input, options);
    }

    /// Disassociates an identity provider configuration from a cluster.
    ///
    /// If you disassociate an identity provider from your cluster, users included
    /// in the
    /// provider can no longer access the cluster. However, you can still access the
    /// cluster
    /// with IAM principals.
    pub fn disassociateIdentityProviderConfig(self: *Self, allocator: std.mem.Allocator, input: disassociate_identity_provider_config.DisassociateIdentityProviderConfigInput, options: disassociate_identity_provider_config.Options) !disassociate_identity_provider_config.DisassociateIdentityProviderConfigOutput {
        return disassociate_identity_provider_config.execute(self, allocator, input, options);
    }

    /// Lists the access entries for your cluster.
    pub fn listAccessEntries(self: *Self, allocator: std.mem.Allocator, input: list_access_entries.ListAccessEntriesInput, options: list_access_entries.Options) !list_access_entries.ListAccessEntriesOutput {
        return list_access_entries.execute(self, allocator, input, options);
    }

    /// Lists the available access policies.
    pub fn listAccessPolicies(self: *Self, allocator: std.mem.Allocator, input: list_access_policies.ListAccessPoliciesInput, options: list_access_policies.Options) !list_access_policies.ListAccessPoliciesOutput {
        return list_access_policies.execute(self, allocator, input, options);
    }

    /// Lists the installed add-ons.
    pub fn listAddons(self: *Self, allocator: std.mem.Allocator, input: list_addons.ListAddonsInput, options: list_addons.Options) !list_addons.ListAddonsOutput {
        return list_addons.execute(self, allocator, input, options);
    }

    /// Lists the access policies associated with an access entry.
    pub fn listAssociatedAccessPolicies(self: *Self, allocator: std.mem.Allocator, input: list_associated_access_policies.ListAssociatedAccessPoliciesInput, options: list_associated_access_policies.Options) !list_associated_access_policies.ListAssociatedAccessPoliciesOutput {
        return list_associated_access_policies.execute(self, allocator, input, options);
    }

    /// Lists all managed capabilities in your Amazon EKS cluster. You can use this
    /// operation to get an overview of all capabilities and their current status.
    pub fn listCapabilities(self: *Self, allocator: std.mem.Allocator, input: list_capabilities.ListCapabilitiesInput, options: list_capabilities.Options) !list_capabilities.ListCapabilitiesOutput {
        return list_capabilities.execute(self, allocator, input, options);
    }

    /// Lists the Amazon EKS clusters in your Amazon Web Services account in the
    /// specified Amazon Web Services Region.
    pub fn listClusters(self: *Self, allocator: std.mem.Allocator, input: list_clusters.ListClustersInput, options: list_clusters.Options) !list_clusters.ListClustersOutput {
        return list_clusters.execute(self, allocator, input, options);
    }

    /// Displays the full description of the subscription.
    pub fn listEksAnywhereSubscriptions(self: *Self, allocator: std.mem.Allocator, input: list_eks_anywhere_subscriptions.ListEksAnywhereSubscriptionsInput, options: list_eks_anywhere_subscriptions.Options) !list_eks_anywhere_subscriptions.ListEksAnywhereSubscriptionsOutput {
        return list_eks_anywhere_subscriptions.execute(self, allocator, input, options);
    }

    /// Lists the Fargate profiles associated with the specified cluster in your
    /// Amazon Web Services
    /// account in the specified Amazon Web Services Region.
    pub fn listFargateProfiles(self: *Self, allocator: std.mem.Allocator, input: list_fargate_profiles.ListFargateProfilesInput, options: list_fargate_profiles.Options) !list_fargate_profiles.ListFargateProfilesOutput {
        return list_fargate_profiles.execute(self, allocator, input, options);
    }

    /// Lists the identity provider configurations for your cluster.
    pub fn listIdentityProviderConfigs(self: *Self, allocator: std.mem.Allocator, input: list_identity_provider_configs.ListIdentityProviderConfigsInput, options: list_identity_provider_configs.Options) !list_identity_provider_configs.ListIdentityProviderConfigsOutput {
        return list_identity_provider_configs.execute(self, allocator, input, options);
    }

    /// Returns a list of all insights checked for against the specified cluster.
    /// You can
    /// filter which insights are returned by category, associated Kubernetes
    /// version, and
    /// status. The default filter lists all categories and every status.
    ///
    /// The following lists the available categories:
    ///
    /// * `UPGRADE_READINESS`: Amazon EKS identifies issues that could impact your
    /// ability to upgrade to new versions of Kubernetes. These are called upgrade
    /// insights.
    ///
    /// * `MISCONFIGURATION`: Amazon EKS identifies misconfiguration in your EKS
    /// Hybrid Nodes setup that could impair functionality of your cluster or
    /// workloads. These are called configuration insights.
    pub fn listInsights(self: *Self, allocator: std.mem.Allocator, input: list_insights.ListInsightsInput, options: list_insights.Options) !list_insights.ListInsightsOutput {
        return list_insights.execute(self, allocator, input, options);
    }

    /// Lists the managed node groups associated with the specified cluster in your
    /// Amazon Web Services
    /// account in the specified Amazon Web Services Region. Self-managed node
    /// groups aren't listed.
    pub fn listNodegroups(self: *Self, allocator: std.mem.Allocator, input: list_nodegroups.ListNodegroupsInput, options: list_nodegroups.Options) !list_nodegroups.ListNodegroupsOutput {
        return list_nodegroups.execute(self, allocator, input, options);
    }

    /// List the EKS Pod Identity associations in a cluster. You can filter the list
    /// by the namespace that the
    /// association is in or the service account that the association uses.
    pub fn listPodIdentityAssociations(self: *Self, allocator: std.mem.Allocator, input: list_pod_identity_associations.ListPodIdentityAssociationsInput, options: list_pod_identity_associations.Options) !list_pod_identity_associations.ListPodIdentityAssociationsOutput {
        return list_pod_identity_associations.execute(self, allocator, input, options);
    }

    /// List the tags for an Amazon EKS resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Lists the updates associated with an Amazon EKS resource in your Amazon Web
    /// Services account, in the
    /// specified Amazon Web Services Region.
    pub fn listUpdates(self: *Self, allocator: std.mem.Allocator, input: list_updates.ListUpdatesInput, options: list_updates.Options) !list_updates.ListUpdatesOutput {
        return list_updates.execute(self, allocator, input, options);
    }

    /// Connects a Kubernetes cluster to the Amazon EKS control plane.
    ///
    /// Any Kubernetes cluster can be connected to the Amazon EKS control plane to
    /// view current
    /// information about the cluster and its nodes.
    ///
    /// Cluster connection requires two steps. First, send a [
    /// `RegisterClusterRequest`
    /// ](https://docs.aws.amazon.com/eks/latest/APIReference/API_RegisterClusterRequest.html) to add it to the Amazon EKS control
    /// plane.
    ///
    /// Second, a
    /// [Manifest](https://amazon-eks.s3.us-west-2.amazonaws.com/eks-connector/manifests/eks-connector/latest/eks-connector.yaml) containing the `activationID` and
    /// `activationCode` must be applied to the Kubernetes cluster through it's
    /// native
    /// provider to provide visibility.
    ///
    /// After the manifest is updated and applied, the connected cluster is visible
    /// to the
    /// Amazon EKS control plane. If the manifest isn't applied within three days,
    /// the connected
    /// cluster will no longer be visible and must be deregistered using
    /// `DeregisterCluster`.
    pub fn registerCluster(self: *Self, allocator: std.mem.Allocator, input: register_cluster.RegisterClusterInput, options: register_cluster.Options) !register_cluster.RegisterClusterOutput {
        return register_cluster.execute(self, allocator, input, options);
    }

    /// Initiates an on-demand refresh operation for cluster insights, getting the
    /// latest analysis outside of the standard refresh schedule.
    pub fn startInsightsRefresh(self: *Self, allocator: std.mem.Allocator, input: start_insights_refresh.StartInsightsRefreshInput, options: start_insights_refresh.Options) !start_insights_refresh.StartInsightsRefreshOutput {
        return start_insights_refresh.execute(self, allocator, input, options);
    }

    /// Associates the specified tags to an Amazon EKS resource with the specified
    /// `resourceArn`. If existing tags on a resource are not specified in the
    /// request parameters, they aren't changed. When a resource is deleted, the
    /// tags associated
    /// with that resource are also deleted. Tags that you create for Amazon EKS
    /// resources don't
    /// propagate to any other resources associated with the cluster. For example,
    /// if you tag a
    /// cluster with this operation, that tag doesn't automatically propagate to the
    /// subnets and
    /// nodes associated with the cluster.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Deletes specified tags from an Amazon EKS resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates an access entry.
    pub fn updateAccessEntry(self: *Self, allocator: std.mem.Allocator, input: update_access_entry.UpdateAccessEntryInput, options: update_access_entry.Options) !update_access_entry.UpdateAccessEntryOutput {
        return update_access_entry.execute(self, allocator, input, options);
    }

    /// Updates an Amazon EKS add-on.
    pub fn updateAddon(self: *Self, allocator: std.mem.Allocator, input: update_addon.UpdateAddonInput, options: update_addon.Options) !update_addon.UpdateAddonOutput {
        return update_addon.execute(self, allocator, input, options);
    }

    /// Updates the configuration of a managed capability in your Amazon EKS
    /// cluster. You can update the IAM role, configuration settings, and delete
    /// propagation policy for a capability.
    ///
    /// When you update a capability, Amazon EKS applies the changes and may restart
    /// capability components as needed. The capability remains available during the
    /// update process, but some operations may be temporarily unavailable.
    pub fn updateCapability(self: *Self, allocator: std.mem.Allocator, input: update_capability.UpdateCapabilityInput, options: update_capability.Options) !update_capability.UpdateCapabilityOutput {
        return update_capability.execute(self, allocator, input, options);
    }

    /// Updates an Amazon EKS cluster configuration. Your cluster continues to
    /// function during the
    /// update. The response output includes an update ID that you can use to track
    /// the status
    /// of your cluster update with `DescribeUpdate`.
    ///
    /// You can use this operation to do the following actions:
    ///
    /// * You can use this API operation to enable or disable exporting the
    ///   Kubernetes
    /// control plane logs for your cluster to CloudWatch Logs. By default, cluster
    /// control plane
    /// logs aren't exported to CloudWatch Logs. For more information, see [Amazon
    /// EKS Cluster control plane
    /// logs](https://docs.aws.amazon.com/eks/latest/userguide/control-plane-logs.html) in the
    /// *
    /// Amazon EKS User Guide*
    /// .
    ///
    /// CloudWatch Logs ingestion, archive storage, and data scanning rates apply to
    /// exported control plane logs. For more information, see [CloudWatch
    /// Pricing](http://aws.amazon.com/cloudwatch/pricing/).
    ///
    /// * You can also use this API operation to enable or disable public and
    ///   private
    /// access to your cluster's Kubernetes API server endpoint. By default, public
    /// access is
    /// enabled, and private access is disabled. For more information, see [
    /// Cluster API server
    /// endpoint](https://docs.aws.amazon.com/eks/latest/userguide/cluster-endpoint.html) in the
    /// *
    /// Amazon EKS User Guide*
    /// .
    ///
    /// * You can also use this API operation to choose different subnets and
    ///   security
    /// groups for the cluster. You must specify at least two subnets that are in
    /// different Availability Zones. You can't change which VPC the subnets are
    /// from, the subnets
    /// must be in the same VPC as the subnets that the cluster was created with.
    /// For
    /// more information about the VPC requirements, see
    /// [https://docs.aws.amazon.com/eks/latest/userguide/network_reqs.html](https://docs.aws.amazon.com/eks/latest/userguide/network_reqs.html) in the
    /// *
    /// Amazon EKS User Guide*
    /// .
    ///
    /// * You can also use this API operation to enable or disable ARC zonal shift.
    ///   If
    /// zonal shift is enabled, Amazon Web Services configures zonal autoshift for
    /// the cluster.
    ///
    /// * You can also use this API operation to add, change, or remove the
    /// configuration in the cluster for EKS Hybrid Nodes. To remove the
    /// configuration,
    /// use the `remoteNetworkConfig` key with an object containing both
    /// subkeys with empty arrays for each. Here is an inline example:
    /// `"remoteNetworkConfig": { "remoteNodeNetworks": [],
    /// "remotePodNetworks": [] }`.
    ///
    /// Cluster updates are asynchronous, and they should finish within a few
    /// minutes. During
    /// an update, the cluster status moves to `UPDATING` (this status transition is
    /// eventually consistent). When the update is complete (either `Failed` or
    /// `Successful`), the cluster status moves to `Active`.
    pub fn updateClusterConfig(self: *Self, allocator: std.mem.Allocator, input: update_cluster_config.UpdateClusterConfigInput, options: update_cluster_config.Options) !update_cluster_config.UpdateClusterConfigOutput {
        return update_cluster_config.execute(self, allocator, input, options);
    }

    /// Updates an Amazon EKS cluster to the specified Kubernetes version. Your
    /// cluster continues to
    /// function during the update. The response output includes an update ID that
    /// you can use
    /// to track the status of your cluster update with the [
    /// `DescribeUpdate`
    /// ](https://docs.aws.amazon.com/eks/latest/APIReference/API_DescribeUpdate.html) API operation.
    ///
    /// Cluster updates are asynchronous, and they should finish within a few
    /// minutes. During
    /// an update, the cluster status moves to `UPDATING` (this status transition is
    /// eventually consistent). When the update is complete (either `Failed` or
    /// `Successful`), the cluster status moves to `Active`.
    ///
    /// If your cluster has managed node groups attached to it, all of your node
    /// groups' Kubernetes
    /// versions must match the cluster's Kubernetes version in order to update the
    /// cluster to a new
    /// Kubernetes version.
    pub fn updateClusterVersion(self: *Self, allocator: std.mem.Allocator, input: update_cluster_version.UpdateClusterVersionInput, options: update_cluster_version.Options) !update_cluster_version.UpdateClusterVersionOutput {
        return update_cluster_version.execute(self, allocator, input, options);
    }

    /// Update an EKS Anywhere Subscription. Only auto renewal and tags can be
    /// updated after
    /// subscription creation.
    pub fn updateEksAnywhereSubscription(self: *Self, allocator: std.mem.Allocator, input: update_eks_anywhere_subscription.UpdateEksAnywhereSubscriptionInput, options: update_eks_anywhere_subscription.Options) !update_eks_anywhere_subscription.UpdateEksAnywhereSubscriptionOutput {
        return update_eks_anywhere_subscription.execute(self, allocator, input, options);
    }

    /// Updates an Amazon EKS managed node group configuration. Your node group
    /// continues to
    /// function during the update. The response output includes an update ID that
    /// you can use
    /// to track the status of your node group update with the [
    /// `DescribeUpdate`
    /// ](https://docs.aws.amazon.com/eks/latest/APIReference/API_DescribeUpdate.html) API operation. You can update the Kubernetes labels
    /// and taints for a node group and the scaling and version update
    /// configuration.
    pub fn updateNodegroupConfig(self: *Self, allocator: std.mem.Allocator, input: update_nodegroup_config.UpdateNodegroupConfigInput, options: update_nodegroup_config.Options) !update_nodegroup_config.UpdateNodegroupConfigOutput {
        return update_nodegroup_config.execute(self, allocator, input, options);
    }

    /// Updates the Kubernetes version or AMI version of an Amazon EKS managed node
    /// group.
    ///
    /// You can update a node group using a launch template only if the node group
    /// was
    /// originally deployed with a launch template. Additionally, the launch
    /// template ID or name
    /// must match what was used when the node group was created. You can update the
    /// launch
    /// template version with necessary changes.
    ///
    /// If you need to update a custom AMI in a node group that was deployed with a
    /// launch
    /// template, then update your custom AMI, specify the new ID in a new version
    /// of the launch
    /// template, and then update the node group to the new version of the launch
    /// template.
    ///
    /// If you update without a launch template, then you can update to the latest
    /// available
    /// AMI version of a node group's current Kubernetes version by not specifying a
    /// Kubernetes version in
    /// the request. You can update to the latest AMI version of your cluster's
    /// current Kubernetes
    /// version by specifying your cluster's Kubernetes version in the request. For
    /// information about
    /// Linux versions, see [Amazon EKS optimized Amazon Linux AMI
    /// versions](https://docs.aws.amazon.com/eks/latest/userguide/eks-linux-ami-versions.html) in the
    /// *Amazon EKS User Guide*. For information about Windows versions, see [Amazon
    /// EKS
    /// optimized Windows AMI
    /// versions](https://docs.aws.amazon.com/eks/latest/userguide/eks-ami-versions-windows.html) in the *Amazon EKS User Guide*.
    ///
    /// You cannot roll back a node group to an earlier Kubernetes version or AMI
    /// version.
    ///
    /// When a node in a managed node group is terminated due to a scaling action or
    /// update,
    /// every `Pod` on that node is drained first. Amazon EKS attempts to drain the
    /// nodes
    /// gracefully and will fail if it is unable to do so. You can `force` the
    /// update
    /// if Amazon EKS is unable to drain the nodes as a result of a `Pod` disruption
    /// budget issue.
    pub fn updateNodegroupVersion(self: *Self, allocator: std.mem.Allocator, input: update_nodegroup_version.UpdateNodegroupVersionInput, options: update_nodegroup_version.Options) !update_nodegroup_version.UpdateNodegroupVersionOutput {
        return update_nodegroup_version.execute(self, allocator, input, options);
    }

    /// Updates a EKS Pod Identity association. In an update, you can change the IAM
    /// role, the target IAM role, or `disableSessionTags`.
    /// You must change at least one of these in an update. An association can't be
    /// moved
    /// between clusters, namespaces, or service accounts. If you need to edit the
    /// namespace
    /// or service account, you need to delete the association and then create a new
    /// association with your desired settings.
    ///
    /// Similar to Amazon Web Services IAM behavior, EKS Pod Identity associations
    /// are eventually consistent,
    /// and may take several seconds to be effective after the initial API call
    /// returns
    /// successfully. You must design your applications to account for these
    /// potential delays.
    /// We recommend that you don’t include association create/updates in the
    /// critical, high-availability code paths of your application. Instead, make
    /// changes in a
    /// separate initialization or setup routine that you run less frequently.
    ///
    /// You can set a *target IAM role* in the same or a different
    /// account for advanced scenarios. With a target role, EKS Pod Identity
    /// automatically performs two
    /// role assumptions in sequence: first assuming the role in the association
    /// that is in this
    /// account, then using those credentials to assume the target IAM role. This
    /// process
    /// provides your Pod with temporary credentials that have the permissions
    /// defined in the
    /// target role, allowing secure access to resources in another Amazon Web
    /// Services account.
    pub fn updatePodIdentityAssociation(self: *Self, allocator: std.mem.Allocator, input: update_pod_identity_association.UpdatePodIdentityAssociationInput, options: update_pod_identity_association.Options) !update_pod_identity_association.UpdatePodIdentityAssociationOutput {
        return update_pod_identity_association.execute(self, allocator, input, options);
    }

    pub fn describeAddonVersionsPaginator(self: *Self, params: describe_addon_versions.DescribeAddonVersionsInput) paginator.DescribeAddonVersionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeClusterVersionsPaginator(self: *Self, params: describe_cluster_versions.DescribeClusterVersionsInput) paginator.DescribeClusterVersionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAccessEntriesPaginator(self: *Self, params: list_access_entries.ListAccessEntriesInput) paginator.ListAccessEntriesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAccessPoliciesPaginator(self: *Self, params: list_access_policies.ListAccessPoliciesInput) paginator.ListAccessPoliciesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAddonsPaginator(self: *Self, params: list_addons.ListAddonsInput) paginator.ListAddonsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAssociatedAccessPoliciesPaginator(self: *Self, params: list_associated_access_policies.ListAssociatedAccessPoliciesInput) paginator.ListAssociatedAccessPoliciesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listCapabilitiesPaginator(self: *Self, params: list_capabilities.ListCapabilitiesInput) paginator.ListCapabilitiesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listClustersPaginator(self: *Self, params: list_clusters.ListClustersInput) paginator.ListClustersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listEksAnywhereSubscriptionsPaginator(self: *Self, params: list_eks_anywhere_subscriptions.ListEksAnywhereSubscriptionsInput) paginator.ListEksAnywhereSubscriptionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listFargateProfilesPaginator(self: *Self, params: list_fargate_profiles.ListFargateProfilesInput) paginator.ListFargateProfilesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listIdentityProviderConfigsPaginator(self: *Self, params: list_identity_provider_configs.ListIdentityProviderConfigsInput) paginator.ListIdentityProviderConfigsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listInsightsPaginator(self: *Self, params: list_insights.ListInsightsInput) paginator.ListInsightsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listNodegroupsPaginator(self: *Self, params: list_nodegroups.ListNodegroupsInput) paginator.ListNodegroupsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPodIdentityAssociationsPaginator(self: *Self, params: list_pod_identity_associations.ListPodIdentityAssociationsInput) paginator.ListPodIdentityAssociationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listUpdatesPaginator(self: *Self, params: list_updates.ListUpdatesInput) paginator.ListUpdatesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn waitUntilAddonActive(self: *Self, params: describe_addon.DescribeAddonInput) aws.waiter.WaiterError!void {
        var w = waiters.AddonActiveWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilAddonDeleted(self: *Self, params: describe_addon.DescribeAddonInput) aws.waiter.WaiterError!void {
        var w = waiters.AddonDeletedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilClusterActive(self: *Self, params: describe_cluster.DescribeClusterInput) aws.waiter.WaiterError!void {
        var w = waiters.ClusterActiveWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilClusterDeleted(self: *Self, params: describe_cluster.DescribeClusterInput) aws.waiter.WaiterError!void {
        var w = waiters.ClusterDeletedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilFargateProfileActive(self: *Self, params: describe_fargate_profile.DescribeFargateProfileInput) aws.waiter.WaiterError!void {
        var w = waiters.FargateProfileActiveWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilFargateProfileDeleted(self: *Self, params: describe_fargate_profile.DescribeFargateProfileInput) aws.waiter.WaiterError!void {
        var w = waiters.FargateProfileDeletedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilNodegroupActive(self: *Self, params: describe_nodegroup.DescribeNodegroupInput) aws.waiter.WaiterError!void {
        var w = waiters.NodegroupActiveWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilNodegroupDeleted(self: *Self, params: describe_nodegroup.DescribeNodegroupInput) aws.waiter.WaiterError!void {
        var w = waiters.NodegroupDeletedWaiter{ .client = self, .params = params };
        return w.wait();
    }
};
