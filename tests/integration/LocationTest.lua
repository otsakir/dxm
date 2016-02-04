local http = require "socket.http"
require "TestUtils"

describe("Busted unit testing framework", function()
  local sessionCookie;
  local loginStatusCode;
  setup(function ()
    body, loginStatusCode, headers = http.request("http://localhost:8080/login?username=tester@gmail.com&password=1234")
    sessionCookie = headers["set-cookie"]
    --assert.are.equal(1,1)
    --assert.are.equal(code, 200)
    --assert.Truthy(sessionCookie)
  end)
  it("Login", function ()
    assert.are.equal(200, loginStatusCode)
    assert.Truthy(sessionCookie)
  end)

  describe("Location methods", function ()
    it("Get location", function ()
      r,code = http.request{
        url = "http://localhost:8080/api/locations",
        headers = { ["Cookie"] = sessionCookie }
      }
      assert.are.equal(200,code)
    end)
  end)
  
end)
