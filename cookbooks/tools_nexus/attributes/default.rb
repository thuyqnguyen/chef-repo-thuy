#Check_mk
default['omd']['omd_server'] = 'oprdmtaws304.corp.intuit.net'
default['check_mk_install']['mirror']  = "http://sds-repo-int.qdc.intuit.com:8081/nexus/content/repositories/CTO.OPS-releases/com/intuit/CTO/OPS-releases/check_mk-agent/1.2.4p5"
default['check_mk_download']['dir']   = "/tmp"
######### For Proxy #############
case node['dczone'][3..4]
        when 'qy'
                case node['dczone'][0..2]
                        when 'prd'
                                default['app']['proxy'] = 'qy1prdproxy01.ie.intuit.net'
                        else
                                default['app']['proxy'] = 'qy1prdproxy01.pprod.ie.intuit.net'
                end
        when 'lv'
                case node['dczone'][0..2]
                        when 'prd'
                                default['app']['proxy'] = 'lvdcproxy01.ie.intuit.net'
                        else
                                default['app']['proxy'] = 'lvdcproxy01.pprod.ie.intuit.net'
                end
end

####### For NO Proxy ##########
case node['dczone'][0..2]
        when 'prd'
                default['app']['no_proxy'] = '"localhost\|*.intuit.net\|sds-repo-int.qdc.intuit.com\|172.*\|10.*"'
        when 'prf'
                default['app']['no_proxy'] = '"localhost\|*.intuit.net\|sds-repo-int.qdc.intuit.com\|172.*\|10.*"'
	      when 'e2e'
		            default['app']['no_proxy'] = '"localhost\|*.intuit.net\|sds-repo-int.qdc.intuit.com\|172.*\|10.*"'
end
