sub init()
  m.version = "1.0.0"
  m.deviceInfo = CreateObject("roDeviceInfo")
  m.sectionRegistryName = "BitmovinAnalytics"
  clearSample()
  updateUserId(m.sectionRegistryName, m.deviceInfo)
  m.analyticsDataTask = m.top.findNode("analyticsDataTask")
end sub

sub clearSample()
  m.sample = getAnalyticsSample()
  updateChannelInfo()
  updateDeviceInfo()
end sub

sub updateChannelInfo()
  appInfo = CreateObject("roAppInfo")
  m.sample.domain = appInfo.GetID()
end sub

sub updateDeviceInfo()
  deviceInfo = CreateObject("roDeviceInfo")
  m.sample.userAgent = "roku-" + deviceInfo.GetModel() + "-" + deviceInfo.GetVersion()
  m.sample.screenHeight = deviceInfo.GetDisplaySize().h
  m.sample.screenWidth = deviceInfo.GetDisplaySize().w
end sub

sub updateVersion()
  m.sample.analyticsVersion = m.version
end sub

sub updateUserId(sectionRegistryName, deviceInfo)
  userId = readFromRegistry(sectionRegistryName, "userId")
  if userId = invalid
    userId = deviceInfo.GetRandomUUID()
    userIdData = {key: "userId", value: userId}
    writeToRegistry(sectionRegistryName, userIdData)
  end if

  m.sample.append({userId: userId})
end sub

function getVersion()
  return m.version
end function

function createImpressionId()
  return m.deviceInfo.GetRandomUUID()
end function

function getCurrentImpressionId()
  return m.sample.impressionId
end function

' TODO: Error handling if the keys are invalid
sub updateSample(values)
  for each v in values
    m.sample.append(values)
  end for
end sub

' sub sendAnalyticsRequest(data)
sub sendAnalyticsRequest()
  m.analyticsDataTask.sendData = true
end sub
