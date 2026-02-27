const EksContainerDetail = @import("eks_container_detail.zig").EksContainerDetail;
const ImagePullSecret = @import("image_pull_secret.zig").ImagePullSecret;
const EksMetadata = @import("eks_metadata.zig").EksMetadata;
const EksVolume = @import("eks_volume.zig").EksVolume;

/// The details for the pod.
pub const EksPodPropertiesDetail = struct {
    /// The properties of the container that's used on the Amazon EKS pod.
    containers: ?[]const EksContainerDetail,

    /// The DNS policy for the pod. The default value is `ClusterFirst`. If the
    /// `hostNetwork` parameter is not specified, the default is
    /// `ClusterFirstWithHostNet`. `ClusterFirst` indicates that any DNS query
    /// that does not match the configured cluster domain suffix is forwarded to the
    /// upstream nameserver
    /// inherited from the node. If no value was specified for `dnsPolicy` in the
    /// [RegisterJobDefinition](https://docs.aws.amazon.com/batch/latest/APIReference/API_RegisterJobDefinition.html) API operation, then no value will be returned for
    /// `dnsPolicy` by either of
    /// [DescribeJobDefinitions](https://docs.aws.amazon.com/batch/latest/APIReference/API_DescribeJobDefinitions.html)
    /// or
    /// [DescribeJobs](https://docs.aws.amazon.com/batch/latest/APIReference/API_DescribeJobs.html) API operations. The pod spec setting will contain either
    /// `ClusterFirst` or `ClusterFirstWithHostNet`, depending on the value of the
    /// `hostNetwork` parameter. For more information, see [Pod's DNS
    /// policy](https://kubernetes.io/docs/concepts/services-networking/dns-pod-service/#pod-s-dns-policy) in the *Kubernetes documentation*.
    ///
    /// Valid values: `Default` | `ClusterFirst` |
    /// `ClusterFirstWithHostNet`
    dns_policy: ?[]const u8,

    /// Indicates if the pod uses the hosts' network IP address. The default value
    /// is
    /// `true`. Setting this to `false` enables the Kubernetes pod networking model.
    /// Most Batch workloads are egress-only and don't require the overhead of IP
    /// allocation for each
    /// pod for incoming connections. For more information, see [Host
    /// namespaces](https://kubernetes.io/docs/concepts/security/pod-security-policy/#host-namespaces) and [Pod networking](https://kubernetes.io/docs/concepts/workloads/pods/#pod-networking)
    /// in the *Kubernetes documentation*.
    host_network: ?bool,

    /// Displays the reference pointer to the Kubernetes secret resource. These
    /// secrets help to gain
    /// access to pull an images from a private registry.
    image_pull_secrets: ?[]const ImagePullSecret,

    /// The container registered with the Amazon EKS Connector agent and persists
    /// the registration
    /// information in the Kubernetes backend data store.
    init_containers: ?[]const EksContainerDetail,

    /// Describes and uniquely identifies Kubernetes resources. For example, the
    /// compute environment that
    /// a pod runs in or the `jobID` for a job running in the pod. For more
    /// information, see
    /// [Understanding Kubernetes
    /// Objects](https://kubernetes.io/docs/concepts/overview/working-with-objects/kubernetes-objects/) in the *Kubernetes documentation*.
    metadata: ?EksMetadata,

    /// The name of the node for this job.
    node_name: ?[]const u8,

    /// The name of the pod for this job.
    pod_name: ?[]const u8,

    /// The name of the service account that's used to run the pod. For more
    /// information, see
    /// [Kubernetes service
    /// accounts](https://docs.aws.amazon.com/eks/latest/userguide/service-accounts.html) and [Configure a Kubernetes service account
    /// to assume an IAM
    /// role](https://docs.aws.amazon.com/eks/latest/userguide/associate-service-account-role.html) in the *Amazon EKS User Guide* and [Configure service accounts for pods](https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/) in the *Kubernetes
    /// documentation*.
    service_account_name: ?[]const u8,

    /// Indicates if the processes in a container are shared, or visible, to other
    /// containers in the
    /// same pod. For more information, see [Share
    /// Process Namespace between Containers in a
    /// Pod](https://kubernetes.io/docs/tasks/configure-pod-container/share-process-namespace/).
    share_process_namespace: ?bool,

    /// Specifies the volumes for a job definition using Amazon EKS resources.
    volumes: ?[]const EksVolume,

    pub const json_field_names = .{
        .containers = "containers",
        .dns_policy = "dnsPolicy",
        .host_network = "hostNetwork",
        .image_pull_secrets = "imagePullSecrets",
        .init_containers = "initContainers",
        .metadata = "metadata",
        .node_name = "nodeName",
        .pod_name = "podName",
        .service_account_name = "serviceAccountName",
        .share_process_namespace = "shareProcessNamespace",
        .volumes = "volumes",
    };
};
