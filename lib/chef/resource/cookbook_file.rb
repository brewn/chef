#
# Author:: Adam Jacob (<adam@chef.io>)
# Author:: Seth Chisamore (<schisamo@chef.io>)
# Author:: Tyler Cloke (<tyler@chef.io>)
# Copyright:: Copyright 2008-2016, Chef Software Inc.
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require "chef/resource/file"
require "chef/provider/cookbook_file"
require "chef/mixin/securable"

class Chef
  class Resource
    class CookbookFile < Chef::Resource::File
      include Chef::Mixin::Securable

      resource_name :cookbook_file

      description "Use the cookbook_file resource to transfer files from a sub-directory"\
                  " of COOKBOOK_NAME/files/ to a specified path located on a host that is"\
                  " running the chef-client. The file is selected according to file specificity,"\
                  " which allows different source files to be used based on the hostname, host"\
                  " platform (operating system, distro, or as appropriate), or platform version."\
                  " Files that are located in the COOKBOOK_NAME/files/default sub-directory may be"\
                  " used on any platform.\n\n"\
                  "During a chef-client run, the checksum for each local file is calculated and then"\
                  " compared against the checksum for the same file as it currently exists in the"\
                  " cookbook on the Chef server. A file is not transferred when the checksums match."\
                  " Only files that require an update are transferred from the Chef server to a node."

      property :source, [ String, Array ], default: lazy { ::File.basename(name) }
      property :cookbook, String

      default_action :create
    end
  end
end
