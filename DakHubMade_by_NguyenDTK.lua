-- code tạo gui, tạo ảnh theo hàng, cột (6 hàng, 4 cột)
-- code này được viết bởi NguyenDTK | Discord: BestClownEver#3117
-- hiếm lắm mới cho xem source đấy nhá, biết ơn tao đê
-- dành hẳn 4 ngày để làm một cái gui dảk vãi kít

-- Cho link ảnh vào đây :> 
local imagePaths = {
    -- cái ảnh này là bạn tao lấy hộ nhá, không phải là tao vào rule34 đâu :>
    "https://api-cdn.rule34.xxx/samples/6809/sample_11e8991590a20f9057cb6733ae43edd9.jpg",
}
syn = false
if syn or KRNL_LOADED then -- kiểm tra xem có dùng synx hoặc krnl không, nếu có thì cho qua, nếu không thì cút
spawn(function()
    -- dùng spawn(function() để tiết kiệm dung lượng và thời gian
    -- xoá cái gui cũ(nếu có) rồi mới load gui mới không là lag, đè ảnh
    game:GetService("Players").LocalPlayer.PlayerGui.PornHub:Destroy() 
end)
wait(1) -- spawn function chậm 1 giây so với môi trường thường
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.Players.LocalPlayer.PlayerGui
screenGui.Name = "PornHub"
-- Tạo Frame và đặt kích thước
local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(0, 420, 0, 340) -- Kích thước Frame là 420x340
frame.Position = UDim2.new(0.5, -210, 0.5, -170) -- Đặt giữa màn hình
frame.BackgroundTransparency = 0

-- Tạo các hàng và cột trong Frame
for i = 1, 4 do
    local row = Instance.new("Frame")
    row.Name = "Row"..i
    row.Size = UDim2.new(1, 0, 0, 80)
    row.Position = UDim2.new(0, 0, 0, (i-1)*80)
    row.BackgroundTransparency = 1
    row.Parent = frame
    
    for j = 1, 6 do
        local column = Instance.new("Frame")
        column.Name = "Column"..j
        column.Size = UDim2.new(0, 70, 0, 80)
        column.Position = UDim2.new(0, (j-1)*70, 0, 0)
        column.BackgroundTransparency = 1
        column.Parent = row
    end
end

-- Tạo nút chuyển trang và đặt tọa độ
local button = Instance.new("TextButton")
button.Name = "NextButton"
button.Size = UDim2.new(0, 100, 0, 50)
button.Position = UDim2.new(0.5, -50, 1, -60)
button.Text = "Next"
button.Parent = frame

-- Biến trang
local page = 1

-- Hàm hiển thị các hình ảnh
local function showImages()
    for i = 1, 4 do
        local row = frame:FindFirstChild("Row"..i)
        if row then
            for j = 1, 6 do
                local column = row:FindFirstChild("Column"..j)
                if column then
                    local index = (page-1)*18 + (i-1)*6 + j
                    if index <= #imagePaths then
                        local radname = math.random(1,99999)..".png"
                        writefile(radname, game:HttpGet(imagePaths[index])) -- tạo một tệp ảnh từ mảng ảnh bằng tên số ngẫu nhiên
                        local imageFrame = Instance.new("Frame")
                        imageFrame.Name = "ImageFrame"
                        imageFrame.Size = UDim2.new(1, 0, 1, 0)
                        imageFrame.BackgroundTransparency = 1
                        imageFrame.Parent = column

                        local image = Instance.new("ImageLabel")
                        image.Name = "Image"
                        image.Size = UDim2.new(0.9, 0, 0.9, 0)
                        image.Position = UDim2.new(0.05, 0, 0.05, 0)
                        image.BackgroundTransparency = 1
                        if syn then
                            image.Image = getsynasset(radname) -- dùng hàm lấy ảnh không thông qua roblox của synapse
                        else if KRNL_LOADED then
                            image.Image = getcustomasset(radname) -- dùng hàm lấy ảnh không thông qua roblox của KRNL
                        end
                        image.Parent = imageFrame
                        spawn(function()
                            wait(3) -- đợi 3 giây để nó tải ảnh về, trình lên trên gui rồi mới xoá
                            delfile(radname) -- xoá ảnh đi chứ không có thằng vào máy mày xem đấy :> (tiết kiệm dung dượng, hạn chế trùng tên)
                        end)
                    end
                end
            end
        end
    end
end
end
-- Hiển thị các hình ảnh ban đầu
showImages()

-- Xử lý sự kiện nhấn nút "NextButton"
button.MouseButton1Click:Connect(function()
    page = page + 1
    if page > math.ceil(#imagePaths/18) then
        page = 1
    end
    
    -- Xóa các hình ảnh trong Frame
    for i = 1, 4 do
        local row = frame:FindFirstChild("Row"..i)
        if row then
            for j = 1, 6 do
                local column = row:FindFirstChild("Column"..j)
                if column then
                    local imageFrame = column:FindFirstChild("ImageFrame")
                    if imageFrame then
                        imageFrame:Destroy()
                    end
                end
            end
        end
    end
    
    -- Hiển thị các hình ảnh trên trang mới
    showImages()
end)
-- code làm cho gui chuyển động được 
local UserInputService = game:GetService("UserInputService")
	local gui = Frame
	local dragging
	local dragInput
	local dragStart
	local startPos
	local function update(input)
		local delta = input.Position - dragStart
		gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
	gui.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = gui.Position
	
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)
	gui.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)
	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			update(input)
		end
	end)
	else
        game.Players.LocalPlayer:Kick('/75/104/195/180/110/103/32/100/195/185/110/103/32/83/121/110/97/112/115/101/32/88/32/104/111/225/186/183/99/32/75/82/78/76/32/116/104/195/172/32/99/195/186/116')
end